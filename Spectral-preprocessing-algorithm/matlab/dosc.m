function [Z,W,P,T] = dosc(X,Y,nocomp,tol)
%  DOSC Direct Orthogonal Signal Correction
%
%  [Z,W,P,T] = dosc(X,Y,nocomp,tol);
%
%  Input
%     X       Matrix of predictor variables (usually spectra)  (I x J)
%     Y       Predicted variables (e.g. concentration)         (I x K)
%     nocomp  number of DOSC components to calculate           
%     tol     tolerance used to calculate pseudinverse of X
%             a tolerance of 1E-3 worked well in two cases presented in paper [1]  
%
%
%  Output
%     Z       DOSC corrected matrix X                          (I x J)
%     W       Weights used to determine DOSC components        (J x nocomp)
%     P       Loadings used to remove DOSC component from X    (J x nocomp)
%     T       DOSC components                                  (I x nocomp)
%  
%  
%  Once the calibration is done, new (scaled) x-data can be corrected by 
%  newx = x - x*W*P'; Or use mfile dosc_pred
%
% See Reference
% Westerhuis JA, de Jong S and Smilde AK, Direct orthogonal signal correction, 
% Chemometrics and Intelligent Laboratory Systems, 56, (2001), 13-25.

% Sijmen de Jong, Oct 99
% Adjusted by Johan Westerhuis
%   ==========================================================================
%   Copyright 2005 Biosystems Data Analysis Group ; Universiteit van Amsterdam
%   ==========================================================================

% project Y onto X      (step 1)
Yhat = X*(pinv(X')'*Y);

% deflate X wrt Yhat    (step 2)
AyX = X-Yhat*(pinv(Yhat)*X); 

% find major PCs of AyX
[Ta,D] = eigs(AyX*AyX',nocomp);

% Calculate pseudoinverse of X using tolerance (step 5a)
pinvX = pinv(X',tol)';

% The tolerance can be changed to the number of PCR components (nc) used
% to estimate the pseudo inverse.
% [U,S,V] = svd(X,0);
% Xcorr = U(:,1:nc)*S(1:nc,1:nc)*V(:,1:nc)';
% pinvX = pinv(Xcorr);

W = pinvX*Ta;
T = X*W;

% Calculate loadings to remove DOSC component (step 7a)
P = X'*T*inv(T'*T);

% deflate X wrt to DOSC components (step 6a)
Z = X - T*P';