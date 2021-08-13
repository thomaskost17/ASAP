function h_new = adapt_LMS(x,h_old,e,u)
    h_new = h_old - u*conj(e).*x;
end
function h_new = adapt_NLMS(x,h_old,e)
    h_new = h_old - (conj(e).*x)/(x'*x);

end