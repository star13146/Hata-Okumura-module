function [array] =module(bh,mh, f ,dense)
%%this function is used to calculate the path_loss behaviour of the uplink
%%and downlink spectrum bands,with an input parameter as base antenna
%%height, mobile antenna height in m, frequency of the system ihn MHz, distance between
%%the base and mobile in km and weather the aera is a dense urban area
    close all;  %ensure the process is not influenced by other data
    % initiate viaraibles with a base condition 1<f<1500 MHz
    %and aera is not dense urban
    k0=3;
    k1=69.55;
    k2=26.16;
    path_loss=0;
    d=1;
    
    if bh < 30 || bh >200 || mh < 0 || f<150 || f>2000 || d<1 || d>50
    % default
        path_loss = -1 ;
        return
    end

    if f >= 1500
        k1=46.3;
        k2=33.9;
    end
    cf = ( 1.1 * log10( f ) - 0.7 ) * mh - (1.56 * log10(f) -0.8);
    % cf stands for the correction factor
    if dense
        k0 = 3;
        cf = 3.2 * power(log10( 11.75 * mh ),2 ) -4.97;
    end
    cf=0;
    for i=1:100
        path_loss = k1 + k2 * log10(f) -13.82 * log10(bh) - cf + (44.9 - 6.55 * log10 (bh)) * log10(d) +k0;
        %apply Hata-Okumura module
        array(i)= path_loss;
        d1(i)=d+1;
        %the accuracy is adjustable here, usually use 1 km
        d=d+0.1;
    end
    plot (d1,array);
    fprintf('The maximun path loss is %f', max(array));
    xlabel('d [km]');
    ylabel('L [dB]');
    %achieve the functionality that oupt a graph with each coordinate can
    %be searched and print the maximum path loss.
end 
