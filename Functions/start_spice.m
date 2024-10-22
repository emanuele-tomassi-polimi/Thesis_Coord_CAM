function start_spice()

% Load kernels used by SPICE
cspice_furnsh({
    which('latest_leapseconds.tls')
    which('earth_200101_990628_predict.bpc')
    which('earth_720101_070426.bpc')
    which('earth_000101_200725_200503.bpc')
    which('pck00010.tpc')
})
end
