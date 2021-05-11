function mdist=mdistrib(m,A,B,len,C,R)
    %m migrating population
    %A and B beta distribution parameters
    %len simulation time
    %C is a coeficient from 0 to 1 representing the control of
    %The migration process 1 bein under heavy control, and 0 being uncontrolled
    %R is the expected amount of days for departing
    
    N= zeros(5,len);
    p = rand(1,5);
    psum=sum(p);
    
    P = p/psum;
    eta = 1-C;
    ind = [P(1),P(2),P(3)^(1/eta),P(4)^(1/eta^2),P(5)^(1/eta^3)]; %S,R,E,P,L
    sumind=sum(ind);
    ind = ind/sumind;
    
    
    x = linspace(0, 1, len+2);
    y1 = betapdf(x, A, B);%dist
    
    y2 = zeros(1,len);
    for i=1:len
        y2(i)=y1(i+1);
    end
    y2 = normalize(y2, 'range', [0 1]);
    K = zeros(6,len);
    R=ones(1,len)*R;
    
    if max(y2)==0
    y2=y2+1;
    end
    
    y2 = y2*m;
    y3=poissrnd(y2);
    K = [y3*ind(1);y3*ind(2);y3*ind(3);y3*ind(4);y3*ind(5);R];
    
%     %K(1,i) migration population coming in day i
%     for i=1:len  
%         nsum = sum(N(:,i))-N(1,i);
%         for j=1:5
%             K(j,i)=round((N(j+1,i)/nsum)*(m*(y2(1,i)/y3)));
%         end
%     end
    mdist = K;
    
    
