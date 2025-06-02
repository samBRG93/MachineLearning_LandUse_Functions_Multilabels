


function [cmd,gamma]=Cross_ValidationRBF(X,t)
%%%%matlabda libsvm cross validation
 
bestcv = 0;
for c =50:100:1000
    for g =0.1:0.3:1
        cmd = ['-v 5 -t 2 -c ', num2str(c), ' -g ', num2str(g)];
        cv = svmtrain(double(t)',X,cmd);
        if (cv >= bestcv)
            bestcv = cv; bestc =c; bestg=g;
        end
        %fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
    end
end
 % v 3 con 80 per il cross validation funziona bene
 % v 2 con 80 per cross va meglio di 3
cmd = ['-t 2 -c ', num2str(bestc), ' -g ', num2str(bestg)];
gamma=bestg;