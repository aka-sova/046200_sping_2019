

%% 

filt_noise = 0.125*[0 1 0; 1 4 1; 0 1 0];

% what we got as restoration
syms a K
restor_mx = [0 K 0; K (a-4*K) K; 0 K 0];

conv_mx = 0.125*[0 0 K 0 0 ; 0 (2*K) a (2*K) 0 ; K a (4*a-12*K) a K  ; 0 (2*K) a (2*K) 0 ; 0 0 K 0 0];

% check ourselves:
% let a = 5, K = 3;

restor_mx_sub = subs(restor_mx, [a K], [5 3]);
conv_mx_sub = subs(conv_mx, [a K], [5 3]);

check_1 = imfilter(filt_noise,double(restor_mx_sub),'full');
check_2 = double(conv_mx_sub);

% verify that check_1 = check_2;






