%% this function used to despike 1-dimensional spectrum
function despiked = despike1(data, windowsize, thr)
%% parameter:
% data:  1D spectrum 
% windowsize : window size for median filter, 3 is recommened
% thr : threshold value, a samll positive value to filter the spike, 1e-6 is recommened 
%% config parameters
switch nargin
    case 1
        windowsize = 3;
        thr = 1e-6;
    case 2
        thr = 1e-6;
    case 3
        
    otherwise
        error("Three parameters is need, but %d is given",nargin);
end
%%
    med_data = medfilt1(data, windowsize, 'truncate');
    err =  data - med_data;
    tmp = err;
    % ��λ��
    m = quantile(err,ceil(0.999*length(err)));
    err(err>=m(end)|err<=m(1)) = [];
    pd = fitdist(err,'Normal');
    lw = icdf(pd,thr);
    hw = icdf(pd,1-thr);
    idx = find(tmp>=hw|tmp<=lw);
    if ~isempty(idx)
        fprintf('����%d�����!\n',length(idx));
        data(idx) = med_data(idx);
    end
    despiked = data;
end