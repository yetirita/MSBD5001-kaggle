function [trainedModel, validationRMSE] = trainRegressionModel(trainingData)
% [trainedModel, validationRMSE] = trainRegressionModel(trainingData)
% 返回经过训练的回归模型及其 RMSE。以下代码重新创建在 Regression Learner App 中训练的
% 模型。您可以使用该生成的代码基于新数据自动训练同一模型，或通过它了解如何以程序化方式训练模
% 型。
%
%  输入:
%      trainingData: 一个包含导入 App 中的预测变量和响应列的表。
%
%  输出:
%      trainedModel: 一个包含训练的回归模型的结构体。该结构体中具有各种关于所训练模型的
%       信息的字段。
%
%      trainedModel.predictFcn: 一个对新数据进行预测的函数。
%
%      validationRMSE: 一个包含 RMSE 的双精度值。在 App 中，"历史记录" 列表显示每个
%       模型的 RMSE。
%
% 使用该代码基于新数据来训练模型。要重新训练模型，请使用原始数据或新数据作为输入参数
% trainingData 从命令行调用该函数。
%
% 例如，要重新训练基于原始数据集 T 训练的回归模型，请输入:
%   [trainedModel, validationRMSE] = trainRegressionModel(T)
%
% 要使用返回的 "trainedModel" 对新数据 T2 进行预测，请使用
%   yfit = trainedModel.predictFcn(T2)
%
% T2 必须是一个表，其中至少包含与训练期间使用的预测变量列相同的预测变量列。有关详细信息，请
% 输入:
%   trainedModel.HowToPredict

% 由 MATLAB 于 2020-12-05 07:27:49 自动生成


% 提取预测变量和响应
% 以下代码将数据处理为合适的形状以训练模型。
%
inputTable = trainingData;
predictorNames = {'day', 'month1', 'month2', 'month3', 'month4', 'month5', 'month6', 'month7', 'month8', 'month9', 'month10', 'month11', 'month12', 'time0', 'time1', 'time2', 'time3', 'time4', 'time5', 'time6', 'time7', 'time8', 'time9', 'time10', 'time11', 'time12', 'time13', 'time14', 'time15', 'time16', 'time17', 'time18', 'time19', 'time20', 'time21', 'time22', 'time23', 'weekday1', 'weekday2', 'weekday3', 'weekday4', 'weekday5', 'weekday6', 'weekday7', 'holiday', 't13', 't14', 't15', 't16', 't17', 't18', 't19', 't20', 't21', 't22', 't26', 't27', 't28', 't29', 't30', 't31', 't32', 't57', 't58', 't59', 't60', 't61', 't62', 't63', 't64', 't65', 't66', 't67', 't68', 't69', 't70', 't71', 't72', 't73', 't74', 't75', 't76', 't77', 't78', 't79', 't80', 'd'};
predictors = inputTable(:, predictorNames);
response = inputTable.y;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% 训练回归模型
% 以下代码指定所有模型选项并训练模型。
regressionGP = fitrgp(...
    predictors, ...
    response, ...
    'BasisFunction', 'constant', ...
    'KernelFunction', 'rationalquadratic', ...
    'Standardize', true);

% 使用预测函数创建结果结构体
predictorExtractionFcn = @(t) t(:, predictorNames);
gpPredictFcn = @(x) predict(regressionGP, x);
trainedModel.predictFcn = @(x) gpPredictFcn(predictorExtractionFcn(x));

% 向结果结构体中添加字段
trainedModel.RequiredVariables = {'d', 'day', 'holiday', 'month1', 'month10', 'month11', 'month12', 'month2', 'month3', 'month4', 'month5', 'month6', 'month7', 'month8', 'month9', 't13', 't14', 't15', 't16', 't17', 't18', 't19', 't20', 't21', 't22', 't26', 't27', 't28', 't29', 't30', 't31', 't32', 't57', 't58', 't59', 't60', 't61', 't62', 't63', 't64', 't65', 't66', 't67', 't68', 't69', 't70', 't71', 't72', 't73', 't74', 't75', 't76', 't77', 't78', 't79', 't80', 'time0', 'time1', 'time10', 'time11', 'time12', 'time13', 'time14', 'time15', 'time16', 'time17', 'time18', 'time19', 'time2', 'time20', 'time21', 'time22', 'time23', 'time3', 'time4', 'time5', 'time6', 'time7', 'time8', 'time9', 'weekday1', 'weekday2', 'weekday3', 'weekday4', 'weekday5', 'weekday6', 'weekday7'};
trainedModel.RegressionGP = regressionGP;
trainedModel.About = '此结构体是从 Regression Learner R2020a 导出的训练模型。';
trainedModel.HowToPredict = sprintf('要对新表 T 进行预测，请使用: \n yfit = c.predictFcn(T) \n将 ''c'' 替换为作为此结构体的变量的名称，例如 ''trainedModel''。\n \n表 T 必须包含由以下内容返回的变量: \n c.RequiredVariables \n变量格式(例如矩阵/向量、数据类型)必须与原始训练数据匹配。\n忽略其他变量。\n \n有关详细信息，请参阅 <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appregression_exportmodeltoworkspace'')">How to predict using an exported model</a>。');

% 提取预测变量和响应
% 以下代码将数据处理为合适的形状以训练模型。
%
inputTable = trainingData;
predictorNames = {'day', 'month1', 'month2', 'month3', 'month4', 'month5', 'month6', 'month7', 'month8', 'month9', 'month10', 'month11', 'month12', 'time0', 'time1', 'time2', 'time3', 'time4', 'time5', 'time6', 'time7', 'time8', 'time9', 'time10', 'time11', 'time12', 'time13', 'time14', 'time15', 'time16', 'time17', 'time18', 'time19', 'time20', 'time21', 'time22', 'time23', 'weekday1', 'weekday2', 'weekday3', 'weekday4', 'weekday5', 'weekday6', 'weekday7', 'holiday', 't13', 't14', 't15', 't16', 't17', 't18', 't19', 't20', 't21', 't22', 't26', 't27', 't28', 't29', 't30', 't31', 't32', 't57', 't58', 't59', 't60', 't61', 't62', 't63', 't64', 't65', 't66', 't67', 't68', 't69', 't70', 't71', 't72', 't73', 't74', 't75', 't76', 't77', 't78', 't79', 't80', 'd'};
predictors = inputTable(:, predictorNames);
response = inputTable.y;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% 执行交叉验证
partitionedModel = crossval(trainedModel.RegressionGP, 'KFold', 5);

% 计算验证预测
validationPredictions = kfoldPredict(partitionedModel);

% 计算验证 RMSE
validationRMSE = sqrt(kfoldLoss(partitionedModel, 'LossFun', 'mse'));
