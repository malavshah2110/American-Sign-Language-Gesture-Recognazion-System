clc; clear all;
about = [20	20	21	20	20	27	21];
and = [20	20	20	20	20	24	19];
can = [2	20	23	20	20	27	20];
cop = [1	20	21	20	20	21	18];
deaf = [1	20	22	20	20	22	21];
decide = [10	20	19	20	20	23	22];
father = [20	19	19	20	20	21	20];
find = [20	20	20	20	20	24	20];
go_out = [20	20	20	20	20	21	11];
hearing = [20	20	20	20	20	20	20];
files_count = vertcat(about, and, can,cop,deaf, decide, father, find, go_out, hearing);
filename = {'ABOUT','AND','CAN','COP','DEAF','DECIDE','FATHER','FIND','GO OUT','HEARING'};

disp('=================================');
P = [];
R = [];
F = [];
for fileNo = 1:1:10
    p = [];
    r = [];
    f = [];
    disp(filename{fileNo});
    for user = 1:1:7
        disp(strcat('user', int2str(user)))
        [train_data, test, class] = AS3(files_count,filename,fileNo, user);
        disp('********Decision Tree********');
        tree = fitctree(train_data, 'Class');
        label = predict(tree, test);
        [p1, r1, f1] = accuracy_metric(class, label);
        disp('********SVM********');
        tree = fitcsvm(train_data, 'Class');
        label = predict(tree, test);
        [p2, r2, f2] = accuracy_metric(class, label);
        
        disp('********Neural Network********');
        [p3, r3, f3]=nn_classifier(train_data, test, class);
        
        p = [p;p1 p2 p3];
        r = [r;r1 r2 r3];
        f = [f;f1 f2 f3];
    end
    P = [P;p'];
    R = [R;r'];
    F = [F;f'];
    h = figure('units','normalized','outerposition',[0 0 1 1]);
    bar(p);
    legend({'Decision Tree';'SVM';'Neural Network'},'Location','northeastoutside');
    xlabel('Users');
    ylabel('Value');
    title(strcat('Precision comparison b/w classifiers for action:',filename{fileNo}));
    print(strcat("AS3_plots/Precision_", filename{fileNo}),'-dpng');
    close(h);
    
    h = figure('units','normalized','outerposition',[0 0 1 1]);
    bar(r);
    legend({'Decision Tree';'SVM';'Neural Network'},'Location','northeastoutside');
    xlabel('Users');
    ylabel('Value');
    title(strcat('Recall comparison b/w classifiers for action:',filename{fileNo}));
    print(strcat("AS3_plots/Recall_", filename{fileNo}),'-dpng');
    close(h);
    
    h = figure('units','normalized','outerposition',[0 0 1 1]);
    bar(f);
    legend({'Decision Tree';'SVM';'Neural Network'},'Location','northeastoutside');
    xlabel('Users');
    ylabel('Value');
    title(strcat('F1 Score comparison b/w classifiers for action:',filename{fileNo}));
    print(strcat("AS3_plots/Formula1_", filename{fileNo}),'-dpng');
    close(h);
    
    disp('=================================');
end
csvwrite('AS3_plots/Precisions.csv',P);
csvwrite('AS3_plots/Recall.csv',R);
csvwrite('AS3_plots/F1_score.csv',F);



