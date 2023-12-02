function [table, spectra] = bbcurve(temperatures, wavelength, reference)
    h = 6.626e-34;
    c = 3.0e8;
    k = 1.38e-23;

    wavelength=wavelength*1e-6; % micron to meter
    spectra = zeros(length(temperatures), length(wavelength));
    
    for i = 1:length(temperatures)
        spectra(i, :) = ((2 * h * c^2) ./ (wavelength.^5) ).* (1 ./ (exp((h * c) ./ (wavelength * k * temperatures(i))) - 1));
    end
    spectra = spectra' ./ 1e6; %w * m^-3 to w * m^-2 * um^-1
    wavelength = wavelength*1e6; % meter to micron
    try %try if the user gives refference specrum
        spectra(length(temperatures)+1,:)= reference* 1e4;
        table = array2table(spectra.','VariableNames',[strcat('T= ', cellstr(num2str(temperatures'))); {'Lsat'}]' );
    end
    plot(wavelength, spectra);
    legend([strcat('T= ', cellstr(num2str(temperatures'))); {'Given Spectrum'}]);
    xlabel('Wavelength: µm') 
    ylabel('Radiance: w/m^2/µm') 
    table = array2table(spectra.' );
end
