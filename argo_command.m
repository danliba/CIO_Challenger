%%

    latlim = [-5 -5]; 
      lonlim = [-90 -77]; 
      t = [datenum('oct 15, 2019') datenum('oct 31, 2019')]; 
      f = argofiles(latlim,lonlim,t,'pacific'); 
  
      [lat,lon,t,P,T,S,pn] = argodata(f); 
      
      plot(lon,lat,'ko','markerfacecolor','g') 
        xlabel 'longitude'
        ylabel 'latitude'
        
        figure
        scatter(cell2mat(S(:)),cell2mat(T(:)),30,cell2mat(P(:)),'filled')
        xlabel 'salinity'
        ylabel 'temperature'
        cb = colorbar; 
        ylabel(cb,' pressure ')
        set(cb,'ydir','reverse')
        xlim([33 36]);