function kernel=HIK(Train,Test)

       kernel=sum(min(Train(1,:),Test(1,:)));
