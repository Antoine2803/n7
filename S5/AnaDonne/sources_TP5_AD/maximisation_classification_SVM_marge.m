% fonction maximisation_classification_SVM_marge (pour l'exercice 3)

function [pourcentage_meilleur_classification_SVM_test, lambda_opt_test, ...
          vecteur_pourcentages_bonnes_classifications_SVM_app, ...
          vecteur_pourcentages_bonnes_classifications_SVM_test] = ...
          maximisation_classification_SVM_marge(X_app,Y_app,X_test,Y_test,vecteur_lambda)
    n = length(vecteur_lambda);
    pourcentage_meilleur_classification_SVM_test = 0;
    vecteur_pourcentages_bonnes_classifications_SVM_app = [];
    vecteur_pourcentages_bonnes_classifications_SVM_test = [];
    for i = 1:n
       [X_VS,w,c,code_retour] = estim_param_SVM_marge(X_app,Y_app,vecteur_lambda(i));
       Y_pred = classification_SVM(X_test,w,c);
       pourcentage = sum(Y_pred == Y_test)/length(Y_test);

       if pourcentage > pourcentage_meilleur_classification_SVM_test
           pourcentage_meilleur_classification_SVM_test = pourcentage;
           lambda_opt_test = vecteur_lambda(i);
       end
       
       vecteur_pourcentages_bonnes_classifications_SVM_test = [vecteur_pourcentages_bonnes_classifications_SVM_test ; pourcentage];

        
    
    
    end
end