clear
clc
close all

A = xlsread('AllprofilesAMT29.xlsx');

%%Defining variables: OJO Matlab no lee la primera fila que es texto, si quiero
%%hay funciones para hacerlo
lat = A (:,2);
latint = [linspace(min(lat),max(lat),91)];   %malla para latitud que vaya del min al max equidistantement
depth = A (:,11);
presint = (1:1:180); presint = presint';  %crea matriz interpolada para ver toda la malla de profundidades desde 0 a 180 (dentro de capa f�tica) que es el max de 1 en 1, y quiero que se repita de manera equidistante desde min lat a max lat
T = A(:,13);
S = A (:, 9);
dens = A (:, 12);
fluo = A (:, 6);
fluo(fluo<0)=0;



% FIGURAS
figure () %INTERPOLANDO

%define tamaño de hoja:
xSize=21;
ySize=7;
xLeft=(21-xSize)/2;
yTop=(7-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize]); %get current figure con fondo blanco
set(gcf,'Position',[xLeft yTop xSize*50 ySize*50]);
set(gcf,'color',[1 1 1]);

%%dens contour vs fluo pcolor
%aqu� serria para ponerle los los ticks de los ejes customized
%set(gca,'tickdir','out','Xtick',xtick_tick1,'Xticklabel',[],'Ytick',[-30 -20 -10],'Yticklabel',[],'fontsize',12);

% malla de colores para fluo
[x,y]= meshgrid(latint,presint);
%voy a interpolar valores de fluo en la malla que acabo de crear (x,y), como es
%la variable que muestro debe ser interpolada sobre la malla que he creado
fluoint= griddata(lat(isfinite(fluo)),depth(isfinite(fluo)),fluo(isfinite(fluo)),x(1,:),y(:,1));


%OJO que la funcion pcolor por defecto elimina el ultimo perfil, se podria
%repetir ese ultimo pefil para solventar
fluoint = [fluoint,fluoint(:,end)];
%presint=[presint,presint(:,end)];
latint=[latint,latint(:,end)+1.0106];

pcolor(-latint,-presint,log10(fluoint)); %la ultima variable es la que da el color y tiene que ser una matriz (en este caso el log10 de la fluorescencia), esta todo interpolado
shading flat %esto elimina una malla negra que sale si no pones esta linea (hay otros tipos, como shading interp, yo uso este)
map = brewermap(150,'YlGn'); %esto es una funcion que trae distintos colores que se suelen utilizar para representar variables del océano
colormap(map);
%colormap('parula');
caxis([-1.5 0])
xlim([min(-latint)-.5 max(-latint)+.5]);
ylim([-182 0]);

%nombre a los ejes y etiquetas (numeritos)
xlabel('Latitude','FontWeight','normal','fontsize',13);
ylabel('Depth (m)','FontWeight','normal','fontsize',13);
set(gca,'tickdir','out','Xtick',[-45 -35 -25 -15 -5 0 5 15 25 35 45],'Xticklabel',[{'45ºN' '35ºN' '25ºN' '15ºN' '5ºN' '0º' '5ºS' '15ºS' '25ºS' '35ºS' '45ºS'}],'Ytick',[-200 -150 -100 -50 0],'Yticklabel',[200 150 100 50 0],'fontsize',13);


% Superponer ciertos puntos
B = xlsread('DATA_ODV_AMT29.xlsx','DFM');
lonB=B(:,1);
latB=B(:,2);
depthB=B(:,5);
PARB=B(:,32);
nutriB=B(:,33);
DCMB=B(:,34);

hold on;
%Repetir todas las veces que sea necesario, scatter siempre es x,y y el
%tama�o de punto, en este caso 60 y despu�s podr�a cambiar el tama�o y
%color

scatter(-latB(isfinite(PARB)),-PARB(isfinite(PARB)),75,'o','filled','MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',1);
scatter(-latB(isfinite(nutriB)),-nutriB(isfinite(nutriB)),80,'s','filled', 'MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',1);
scatter(-latB(isfinite(DCMB)),-DCMB(isfinite(DCMB)),75,'^','filled','MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',1);
%%la x es lat y la y el punto

%Para poner la leyenda
scatter(-45,-155,80,'o','MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',1);
scatter(-45,-165,85,'s','MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',1);
scatter(-45,-175,80,'^','MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',1);
text(-43,-155,'1%PAR_z','color','k','fontweight','bold','fontsize',14);
text(-43,-165,'Nutricline_z','color','k','fontweight','bold','fontsize',14);
text(-43,-175,'DCM_z','color','k','fontweight','bold','fontsize',14);


% ISOLINEAS
%Voy a a�adir el grafico de isolineas encima con contour map
%Tenemos que a�adir un meshgrid otra vez sobre el cual plotear las
%isolineas de temp, primero hacemos interpolacion de T y repito el ultimo
%perfil, si lo hiciese con las isol�neas de fluo ser�a lo siguiente:

hold on;
%Tint= griddata(lat(isfinite(T)),depth(isfinite(T)),T(isfinite(T)),x(1,:),y(:,1));
%Tint=[Tint,Tint(:,end)];

latint = latint';%trasponer para que lo ponga en 1 columna en lugar de fila para poder usarla en la funcion contour

vt=[0.15,0.5]; %aquí escoges las isolíneas que quieres poner. en este caso las de fluo 0.15 y 0.5
[C,h] = contour(-latint,-presint,fluoint,vt,'LineWidth',0.8,'LineColor','k'); %se llama C h la funcion por defecto

clabel(C,'manual','FontWeight','normal','fontsize',14) %escoges manuamlente donde quieres poner las etiquetas (numeritos), si no quieres poner más, dale a intro

cb=colorbar;
cb.Label.String=('Fluorescence');
set(cb,'fontsize',14);
%poner las etiquetas en la barra de color (tener en cuenta que estamos
%usando log10):
set(cb,'YTick',[log10(0.0316),log10(.1),log10(.3162),log10(1)],'YTicklabel',[0.03,.1,0.3,1],'fontsize',13,'FontWeight','normal'); %si eliminas esta linea no pasa nada, se ponen los valoes automaticamente.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ISOLINEAS sin interpolar
% figure() % scatter: representacion con puntos que indican el valor real, sin interpolar, de la fluorescencia
%
% xSize=21;
% ySize=7;
% xLeft=(21-xSize)/2;
% yTop=(7-ySize)/2;
% set(gcf,'PaperPosition',[xLeft yTop xSize ySize]); %get current figure con fondo blanco
% set(gcf,'Position',[xLeft yTop xSize*50 ySize*50]);
% set(gcf,'color',[1 1 1]);
%
%
% scatter(-lat,-depth,30, log10(fluo),'filled'); colormap(map)
% ylim([-200 0])
% caxis([-1.5 0])
%
% map=brewermap(25,'YlGn');
% cb=colorbar;
% cb.Label.String=('fluo');
% %set(cb,'position',[xcb ycb wcb hcb]);
% set(cb,'YTick',[log10(0.0316),log10(.1),log10(.3162),log10(1)],'YTicklabel',[0.03,.1,0.3,1],'fontsize',12,'FontWeight','bold');
%
% Z=griddata(lat,depth,T,x,y);
% hold on;
%
% %[C,h]=contour(-x,-y,Z);
%
% %si usas estas lineas en vez de la anterior, seleccionas las isolineas que
% %quieras:
% vt=[0.15,0.3,0.5];
% [C,h]=contour(-x,-y,Z,vt,'LineWidth',1,'LineColor','k');
%
% clabel(C,'FontWeight','normal');
%
% %% Ejes
% xlabel('� Latitude','FontWeight','bold','fontsize',12);
% ylabel('press (dbar)','FontWeight','bold','fontsize',12);
% set(gca,'tickdir','out','Xtick',[-45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45],'Xticklabel',[45, 40, 35, 30, 25, 20, 15, 10, 5, 0, -5, -10, -15, -20, -25, -30, -35, -40, -45],'Ytick',[-200 -150 -100 -50 0],'Yticklabel',[200 150 100 50 0],'fontsize',12);
% %% Superponer ciertos puntos
% B = xlsread('DATA_ODV_AMT29.xlsx','DFM');
% lonB=B(:,1);
% latB=B(:,2);
% depthB=B(:,5);
% PARB=B(:,32);
% nutriB=B(:,33);
% DCMB=B(:,34);
%
% hold on;
% %Repetir todas las veces que sea necesario, scatter siempre es x,y y el
% %tama�o de punto, en este caso 60 y despu�s podr�a cambiar el tama�o y
% %color
%
% scatter(-latB(isfinite(PARB)),-PARB(isfinite(PARB)),70,'o','MarkerEdgeColor','k','LineWidth',1);
% scatter(-latB(isfinite(nutriB)),-nutriB(isfinite(nutriB)),75,'s','MarkerEdgeColor','k','LineWidth',1);
% scatter(-latB(isfinite(DCMB)),-DCMB(isfinite(DCMB)),70,'^','MarkerEdgeColor','k','LineWidth',1);
% %%la x es lat y la y el punto
%
% %Para poner la leyenda
% scatter(32,-165,'o','MarkerEdgeColor','k','LineWidth',1);
% scatter(32,-170,65,'s','MarkerEdgeColor','k','LineWidth',1);
% scatter(32,-175,60,'^','MarkerEdgeColor','k','LineWidth',1);
% text(35,-165,'1%PARz');
% text(35,-170,'Nutriclinez');
% text(35,-175,'DCMz');
