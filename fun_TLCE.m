function [all_samples] =  fun_TLCE(dataseg,K,kernelSize)

tol = 1e-3;
sz = size(dataseg);
all_samples = zeros(K,K,sz(1)-K+1,sz(3),'single'); 
 for i = 1:sz(3)
     h=1;
     for j = 1:sz(1)-K+1
           K_segments = dataseg(j:j+K-1,:,i);  % take K segments as a sample
           K_segments=K_segments';
           tmp=correntropy_matrix(K_segments,kernelSize);  % calculate the correntropy matrix
           all_samples(:,:,j,i) = logm(tmp+tol*eye(size(tmp,1))*(trace(tmp)));  % complete the vector input of SVM through logarithm-Euclidean kernel function
           h=h+1;
            
     end
end


