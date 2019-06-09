function [targets] = ProcessData_4(Yva, thres)
%Proces the whole targets, it returns the targets

[Yt, It] = Thresh_2(Yva ,thres); % get the regions for different input types

It = ceil(mean(It,2));

Avec1 = [It(1):It(2)];
Bvec = [It(2)+1:It(3)];
Avec2 = [It(3)+1:It(4)];
Fvec = [It(4)+1:It(5)];
Avec3 = [It(5)+1:It(6)];
Tvec = [It(6)+1:It(7)];
Avec4 = [It(7)+1:It(8)];
Hvec = [It(8)+1:It(9)];
Avec5 = [It(9)+1:It(10)];

% A training vector (ie no signal)

tA1 = ones(size(Avec1));
tB = zeros(size(Bvec));
tA2 = ones(size(Avec2));
tF = zeros(size(Fvec));
tA3 = ones(size(Avec3));
tT = zeros(size(Tvec));
tA4 = ones(size(Avec4));
tH = zeros(size(Hvec));
tA5 = ones(size(Avec5));

txA = [tA1 tB tA2 tF tA3 tT tA4 tH tA5];

% B training vector (ie B signal)

tA1 = zeros(size(Avec1));
tB  = ones(size(Bvec));    % <===== Signal here
tA2 = zeros(size(Avec2));
tF  = zeros(size(Fvec));
tA3 = zeros(size(Avec3));
tT  = zeros(size(Tvec));
tA4 = zeros(size(Avec4));
tH  = zeros(size(Hvec));
tA5 = zeros(size(Avec5));

txB = [tA1 tB tA2 tF tA3 tT tA4 tH tA5];

% F training vector (ie F signal)

tA1 = zeros(size(Avec1));
tB  = zeros(size(Bvec));
tA2 = zeros(size(Avec2));
tF  = ones(size(Fvec));   % <===== Signal here
tA3 = zeros(size(Avec3));
tT  = zeros(size(Tvec));
tA4 = zeros(size(Avec4));
tH  = zeros(size(Hvec));
tA5 = zeros(size(Avec5));

txF = [tA1 tB tA2 tF tA3 tT tA4 tH tA5];

% T training vector (ie T signal)

tA1 = zeros(size(Avec1));
tB  = zeros(size(Bvec));
tA2 = zeros(size(Avec2));
tF  = zeros(size(Fvec));
tA3 = zeros(size(Avec3));
tT  = ones(size(Tvec));    % <===== Signal here
tA4 = zeros(size(Avec4));
tH  = zeros(size(Hvec));
tA5 = zeros(size(Avec5));

txT = [tA1 tB tA2 tF tA3 tT tA4 tH tA5];

% T training vector (ie T signal)

tA1 = zeros(size(Avec1));
tB  = zeros(size(Bvec));
tA2 = zeros(size(Avec2));
tF  = zeros(size(Fvec));
tA3 = zeros(size(Avec3));
tT  = zeros(size(Tvec));
tA4 = zeros(size(Avec4));
tH  = ones(size(Hvec));   % <===== Signal here
tA5 = zeros(size(Avec5));

txH = [tA1 tB tA2 tF tA3 tT tA4 tH tA5];

% Encoded target matrix
targets = [txA; txB; txF; txT; txH];

h = 1;
end
