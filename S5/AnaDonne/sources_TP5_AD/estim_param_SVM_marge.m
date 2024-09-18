% fonction estim_param_SVM_marge (pour l'exercice 3)

function [X_VS,w,c,code_retour] = estim_param_SVM_marge(X,Y,lambda)
    n = length(X);
    H = diag(Y)*(X*X')*diag(Y);
    f = repmat(-1,1,n);
    Aeq = Y';
    beq = 0;
    LB = 0*X;
    [alpha,~,code_retour] = quadprog(H,f,[],[],Aeq,beq,LB,lambda);
    w = (alpha.*Y).*X;
    size(alpha >= 10E-6);
    
    filter = repmat((alpha >= 10E-6),1,size(X,2));
    w = sum(reshape(w(filter),sum((alpha >= 10E-6)),2));
    
    X_VS = reshape(X(filter),sum((alpha >= 10E-6)),2);
    Yi = Y(alpha >= 10E-6);
    i = 1;
    while (alpha(i,1) >= lambda) && (alpha(i,1) <= 0.00001)
        i = i +1;
    end
    c = X_VS(1,:)*w' - Yi(1,:);
end