function [precision, recall, f1]=accuracy_metric(class, label)
        x = size(class);
        tp = 0;
        tn = 0;
        fp = 0;
        fn = 0;
        for i =1:1:x(1)
            a = class(i);
            b = label(i);
            if a==1 && b==1
                tp = tp+1;
            elseif a==0 && b==0
                tn = tn +1;
            elseif a==1 && b==0
                fn = fn +1; 
            elseif a==0 && b==1
                fp = fp +1; 
            end
        end
        precision = tp/(tp+fp);
        recall = tp/(tp+fn);
        f1 = (2*recall*precision)/(recall + precision);
        disp(strcat('Precision=',num2str(precision)));
        disp(strcat('Recall=',num2str(recall)));
        disp(strcat('F1 Score=',num2str(f1)));

end