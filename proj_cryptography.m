clear all;

%% Problem 1
plaintextfragment = [1;0;1;1;1;1;1;0;1;1;1;0;1;1;1;1;1;1;1;1;1;0;0;1;1;1;1;
    1;0;1;1;0;1;1;0;1;1;0;1;1;0;1;1;1;1;1;1;1;0;1;0;0;1;0;1;1;1;1;1;1];
A = imread('mruyter_ENCRYPTED.png');
A = double(A);
A = A-min(A(:));
A = A/max(A(:));
A = round(A);
A = reshape(A,[262144,1]);

%% Generate a key fragment (P1)
kf = mod(plaintextfragment + A(1:60),2);
disp(strcat(num2str(kf)'));

%% Test determinants (P1)
m = 18;
M = makematrix(kf,m);
disp(strcat(['When m = ',num2str(m)]));
disp(strcat(['Det = ',num2str(mod(round(det(M)),2))]));

%% Solve for C (P1)
pc = mod(round(det(M)*inv(M)*kf(m+1:m+m)),2);
disp('Possible c is:');
disp(strcat(num2str(pc)'));

%% Test pc on existing key fragment (P1)
pkf = genkey(kf(1:m),pc,length(kf));
norm(pkf-kf)

%% Decrypt (P1)
enoughkey = genkey(kf(1:m),pc,262144);
possibleplaintext = mod(A + enoughkey,2);

%% Display (P1)
figure
imshow(reshape(possibleplaintext,[512 512]),'InitialMagnification',5000)

%% Problem 2 (b)
clear all
plaintextfrag = [0;1;0;0;1;1;0;0;1;1;0;1;0;0;0;0;1;1;
    1;1;1;0;1;0;1;0;1;1;0;0;0;0;1;0;0];
cyphertext35 = [1;1;0;0;0;1;0;0;1;0;0;1;1;0;0;1;0;1;
    0;0;0;1;1;0;1;0;0;0;0;0;0;0;1;1;1];
message = [1;1;0;0;0;1;0;0;1;0;0;1;1;0;0;1;0;1;0;0;0;1;1;0;1;0;0;0;0;0;
    0;0;1;1;1;1;1;0;1;1;0;1;0;0;0;0;0;0;0;0;1;1;0;0;1;0;0;0;0;0;1;1;1;1;
    0;0;0;1;0;1;1;1;0;0;1;1;0;0;0;0;0;0;1;0;0];

keyfrag = mod(plaintextfrag + cyphertext35, 2);

%% Problem 2 (c)
m = 13;
% Stopped at m = 13 as consistent zeros were observed for m > 13.
% We now make the matrix m from the key fragment and m = 13, 
% and test that det(M) mod 2 = 1.
M = makematrix(keyfrag, m);
disp(strcat(['When m = ',num2str(m)]));
disp(strcat(['Det = ',num2str(mod(round(det(M)),2))]))

pc = mod(round(det(M)*inv(M)*keyfrag(m+1:m+m)),2);
% Show the possible c that will be used to generate the possible 
% key fragment used to decypher the message.
disp('Possible c is:')
disp(strcat(num2str(pc)'));

pkf = genkey(keyfrag(1:m),pc,length(keyfrag));
% The result of this calculation is 0 for m = 13. This possible key 
% fragment is correct.
norm(pkf-keyfrag)

%% Problem 2 (d)
% generate enough key to decrypt entire message, which is 85 bits long.
enoughkey = genkey(keyfrag(1:m),pc,85);
possibleplaintext = mod(message + enoughkey,2);

%% Problem 2 (e) 
% plain text in binary: 01001 10011 01000 01111 10101 01100 00100 01100 01001
%                       10110 00101 01001 01110 10011 00001 01100 10100

% plain text in decimal: 9 19 8 15 21 12 4 12 9 22 5 9 14 19 1 12 20

% plain text in characters I SHOULD LIVE IN SALT

%% Problem 3 (a)
clear all
s = [1;0;1;1;1;0;0];
c = [1;0;1;1;0;0;0];

fortybits = genkey(s,c,40)

% write out the bits: 1011 1001 0010 1001 1000 0111 0100 0000 1000 1101

%%Problem 3 (b)
% convert to decimal: 11 9 2 9 8 7 4 0 8 13