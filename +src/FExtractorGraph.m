function Features = FExtractorGraph(ptCloud, K)

ptGeom = double(ptCloud.Location);
Features = zeros(9,1);
C = 0.0001;

ptColorL = src.ColorRGBtoL(double(ptCloud.Color));
ptColorL = gather(ptColorL);

[knn_idx, knn_dist] = knnsearch(ptGeom, ptGeom, 'K', K + 1);
knn_idx(:,1) = []; knn_dist(:,1) = []; SIGMA = mean(knn_dist(:,:),'all');

EigMat = zeros(ptCloud.Count,3);
for i=1:ptCloud.Count   
    Neighs = ptGeom(knn_idx(i,:),:);
    Centroid = mean(Neighs,1);    
    Diff = Neighs - Centroid;
    Cov = (Diff' * Diff) ./ K;
    EigMat(i,:) = double(eig(Cov));
end
EigMat = sort(EigMat,2,'descend');
Curvature = EigMat(:,3) ./ (EigMat(:,1) + EigMat(:,2) + EigMat(:,3) + C);
Anisotropy = (EigMat(:,1) - EigMat(:,3)) ./ (EigMat(:,1) + C);
Linearity = (EigMat(:,1) - EigMat(:,2)) ./ (EigMat(:,1) + C) ;
Planarity = (EigMat(:,2) - EigMat(:,3)) ./ (EigMat(:,1) + C); 
Features(1) =  mean(Curvature);
Features(2) =  std(Anisotropy,[],1);
Features(3) =  std(Linearity,[],1);
Features(4) =  mean(Planarity); 
Features(5) =  std(Planarity,[],1);

Signal = zeros(ptCloud.Count, 4);
Signal(:,1:3) = ptGeom;
Signal(:,4) = ptColorL(:,1);

TV_Combi_Weight = zeros(ptCloud.Count, 4);
kernel_weights = exp(-(knn_dist(:,:).^2) ./ (SIGMA*SIGMA));
SignalDiff = zeros(ptCloud.Count, K, 4);

for k=1:K
    SignalDiff(:,k,:) = abs(Signal(:,:) - Signal(knn_idx(:,k),:));
end

for s=1:4
     DiffSumL1 = kernel_weights .* SignalDiff(:,:,s);
     TV_Combi_Weight(:,s) = sum(DiffSumL1,2);
end

Features(6) = sum(TV_Combi_Weight(:,4),1);
Features(7:9) = mean(TV_Combi_Weight(:,1:3),1);

end

