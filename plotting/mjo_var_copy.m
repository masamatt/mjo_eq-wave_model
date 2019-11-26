%
% mjo_var_copy.m - output variables for plotting
%

% declare main variable 'f'ields, fields(xi,y,z)
uf              = 0;
vf              = 0;
phif            = 0;
qf              = 0;
omegaMf         = 0;

% declare horizontal variable fields, fields(xi,y)
uf_hor          = 0;
vf_hor          = 0;
phif_hor        = 0;
qf_hor          = 0;
omegaMf_hor     = 0;

if primitiveModel == 0
    uf          = u;
    vf          = v;
    phif        = phi;
    qf          = q;
    omegaMf     = omegaM;
    
    uf_hor      = UF;
    vf_hor      = VF;
    phif_hor    = PHIF;
    qf_hor      = qF;
    omegaMf_hor = omegaMF;
elseif balancedModel == 0
    uf          = b_u;
    vf          = b_v;
    phif        = b_phi;
    qf          = b_q;
    omegaMf     = b_omegaM;
    
    uf_hor      = bUF;
    vf_hor      = bVF;
    phif_hor    = bPhiF;
    qf_hor      = bqF;
    omegaMf_hor = b_omegaMF;
else
    disp('Error, bad model IDs.');
    return
end

