%
% cleanUpVars - clean up variable space
% 

if  modelType == 0
    clear Amnr Eta H0 HC HC0 Hn NUmnr PHImnr Qmnr
    clear balPath primPath libPath matPath outPath plotPath mjoDir modelSuite 
elseif modelType == 1
    clear Amnr Eta bHC bHC0 Hn NUmn NUmnr psimn qmn Qmn Qmnr
    clear balPath libPath matPath outPath plotPath primPath mjoDir modelSuite
else
    disp(['Bad model ID: ',num2str(modelType),'.'])
end

