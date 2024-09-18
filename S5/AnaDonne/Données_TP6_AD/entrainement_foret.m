% fonction entrainement_foret (pour l'exercice 2)

function foret = entrainement_foret(X,Y,nb_arbres,proportion_individus)
        foret = { };
        for i = 1:nb_arbres
            tirage_donnees = randperm(length(X),floor(proportion_individus*length(X)));
            x_f = X(tirage_donnees,:);
            y_f = Y(tirage_donnees)';
            foret{i} = fitctree(x_f,y_f,'NumVariablesToSample',floor(sqrt(length(X))));
        end
        
end
