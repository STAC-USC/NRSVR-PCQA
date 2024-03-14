PPCFolderName = 'dataset\BASICS\PPC\';
MosFilePath = 'dataset\BASICS\trainset_mos_std_ci.csv';
OutputFeatureDataName = 'Feature\Feature_BASICStraining.csv';

MosStdCiTable = readtable(MosFilePath);
PPCFilenames = string(MosStdCiTable.ppc);
DataCount = size(PPCFilenames, 1);
disptext = sprintf('[INFO] DataCount = %d\n', DataCount); fprintf(disptext);
     
FeatureTable = strings([DataCount+1,6]);
FeatureTable(1,1) = 'PPCName'; 
FeatureTable(1,2) = 'F1'; 
FeatureTable(1,3) = 'F2';  
FeatureTable(1,4) = 'F3';  
FeatureTable(1,5) = 'F4';  
FeatureTable(1,6) = 'F5'; 
FeatureTable(1,7) = 'F6';  
FeatureTable(1,8) = 'F7';  
FeatureTable(1,9) = 'F8'; 
FeatureTable(1,10) = 'F9'; 

for d=1:DataCount

    %% Loading point clouds
    ptCloud = pcread(strcat(PPCFolderName,PPCFilenames(d),'.ply'));
    disptext = sprintf('\n[INFO] Dist PC: %s.ply\n', PPCFilenames(d)); fprintf(disptext);

    %% Calculating features
    Scores = src.FExtractorGraph(ptCloud, 5);
    FeatureTable(d+1,1) = PPCFilenames(d);
    FeatureTable(d+1,2:10) = Scores;

end

writematrix(FeatureTable,OutputFeatureDataName);