function [train_SL,test_SL,test_number]= GenerateSample(labels,train_number,no_classes)

%description:generate training sampels and test samples roundly;
%input:
%      labels:ground truth 
%      train_number:training samples per class
%      no_classes:number of class
%output:
%      train_SL:the index and label of selected training samples
%      test_SL:the index and label of selected test samples


Train_Label = [];
Train_index = [];
count=[];

for ii = 0: no_classes-1
   index_ii =  find(labels == ii);
   count =[count,length(index_ii)];
   class_ii = ones(length(index_ii),1)* ii; 
   Train_Label = [Train_Label class_ii'];
   Train_index = [Train_index index_ii'];   
end

Train_index=Train_index(:);
trainall = zeros(2,length(Train_index));
trainall(1,:) = Train_index;
trainall(2,:) = Train_Label;

indexes =[];

all_sample = [];
train_numbers=[];
for i = 0: no_classes-1
  W_Class_Index = find(Train_Label == i);
  all_sample = [all_sample,length(W_Class_Index)];
  Random_num = randperm(length(W_Class_Index)); 
  Random_Index = W_Class_Index(Random_num);
  if train_number<1
    Num=ceil(length(W_Class_Index)*train_number); % training samples
  else
    Num=train_number;
  end
  if Num>length(W_Class_Index)
            Num=length(W_Class_Index);
  end
  train_numbers=[train_numbers Num];
  Tr_Index = Random_Index(1:Num); 
  indexes = [indexes Tr_Index];
end   
test_number = all_sample -  train_numbers;
indexes = indexes';
train_SL = trainall(:,indexes);
test_SL = trainall; 
test_SL(:,indexes) = [];  % remove training samples from testing samples
end