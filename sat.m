close all;
%% Parameters
M = size(Z,1);
N = size(gth,1);

nbr_of_plots = 4;

%% Display raw image
subplot(1,nbr_of_plots,1)
imshow(Z,[])
title('raw image')

%% 7. Simulation de l'image
x = repmat(gth.',M,1);
W = x.*Z;
%W_auto = gth.'.*Z;
subplot(1,nbr_of_plots,2)
imshow(W,[])
title('Simulated W')

%% Logarithmique
V = log(W);
Y = log(Z);
fth = log(gth.')
subplot(1,nbr_of_plots,3);
imshow(V,[]);
title('Logarithmic image');

%% 8. Méthode 1 - Moyenne empirique

%f_mean = mean(V);
f_mean = abs(mean(V,1) - mean(V,"all"));
f_mean = f_mean - mean(f_mean); % Centré réduit
V_mean = Y + f_mean;

subplot(1,nbr_of_plots,4)
imshow(V_mean,[])
title('With empiric mean method')

%%
figure()
plot(f_mean)
hold on
%plot(f_median)
%hold on
plot(fth,'r')
legend(['mean'],['ideal'])
title('gains')

%% Error sur les gains
err1 = abs(f_mean - fth);
figure()
subplot(1,2,1)
plot(err1)
title('gain error w/ mean')

%% Fourrier Transform

N = nextpow2(M);
fft_mod = abs(fft(err1,N));
subplot(1,2,2)
plot(fft_mod)
title('fft mod of the gain error')

%% Méthode 2 - MAP médiane

delta_v = diff(V,1,2);
delta_f = median(delta_v,1);
f_ML = cumsum(delta_f);

err2 = abs(f_ML - fth(1:452));

%% Méthode 3
N = size(fth,1);

B  = [-1 1; 0 1];


e = ones(N,1);
D = spdiags([-e e ],[0 1], N-1,N);

mu = 1; %A CHANGER

s = mean(V, 1);
A = D' * D + mu * speye(N);
b = D' * D * s';
f_MAP1 = A \ b;


err3 = abs( f_MAP1 - fth.' ) ;

figure;
plot(err3);

%% Méthode 4
f_MAP2 = MAPL1(V.',D,mu); 


err = abs( f_MAP2 - fth.');

figure;
plot(err);

figure
plot(f_MAP2);

%%
figure;
%subplot(1,3,2);
plot(f_mean)
hold on

plot(f_ML);
hold on;

%subplot(1,3,3)
plot(fth);
title('f_n gains')

legend(['Mean estimator'],['Median estimator'],['ideal gains'])

%%
figure;
%subplot(1,3,1);
plot(err1);
hold on

plot(err2)
hold on;

plot(err3);
title('Error');
legend(['Mean'],['Median'],['MAP1']);


