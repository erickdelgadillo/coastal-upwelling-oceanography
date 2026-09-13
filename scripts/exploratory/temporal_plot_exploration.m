
clear
close all

Env = xlsread('All_Metadata.xlsx');
IDXwinter = find (Env (:,2)==2);
winter=Env(IDXwinter,:);

IDXspring = find (Env (:,2)==4);
spring=Env(IDXspring,:);

IDXsummer = find (Env (:,2)==8);
summer=Env(IDXsummer,:);

dateW = winter (:,1:3);
dateS = spring (:,1:3);
dateSM = summer (:,1:3);

dateWN = datenum (dateW);
dateSN = datenum (dateS);
dateSMN = datenum (dateSM);

figure()
%%%%%% nitrate %%%%%%

%defino tamaño de hoja (no tienes por qué hacer esto, podrias borrar hasta
%la linea 42 (incluida)
set(gcf,'PaperUnits','centimeters');
xSize=10;
ySize=4.5;
xLeft=(10-xSize)/2;
yTop=(4.5-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize]);
set(gcf,'Position',[xLeft yTop xSize*50 ySize*50]);
set(gcf,'color',[1 1 1]);

xt=1.05/xSize;
yt=1/ySize;
wt=(7.558-.5)/xSize; %18.4 total
ht=3.2/ySize;
axes('position',[xt yt wt ht]);

stW = winter (:,4);
stS = spring (:,4);
stSM = summer (:,4);

depthW = winter (:,5);
depthS = spring (:,5);
depthSM = summer (:,5);

TINW = winter (:,9);
TINS = spring (:,9);
TINSM = summer (:,9);



% %interpolaci�n   de la variable x
dateINTW=[linspace(min(dateWN),max(dateWN),9)];%aquí empezarías tú, tendrías que poner tu variable x, que es distancia, no sé si lo tienes en longitud, imagino que si

presINT=(1:5:200)'; %creas tu variable profundidad según la prof maxima de tus estaciones. Por ejemplo si tu profundidad máxima es 100, pues creas la variable pres cada metro por ejemplo d ela siguiente forma: pres=(0:1:100)';

[x1d,y1d]=meshgrid(dateINTW,presINT); %creas una malla usando tu variable x (distancia) y tu variable y (profundidad)


TIN_INT_W=gridfit(dateWN(isfinite(TINW)),depthW(isfinite(TINW)),TINW(isfinite(TINW)),x1d(1,:),y1d(:,1)); %interpolas tu variable, en este caso el nitrato, sobre la malla que acabas de crear (yo le llame x1d e y1d al a malla)

% NO3_INT_1(NO3_INT_1<0)=0; %elimino posibles valores erróneos que sean negativos


pcolor(dateINTW,-presINT,TIN_INT_W); %representas tu variable. primero colocas x(en mi caso date, que es el tiempo), luego y (en mi caso la presión en negativo) y luego tu variable de color (mi caso nitrato)
% shading flat; %esto es para que no te pinte una malla de cuadrados negros, así se ve más fluido el gráfico (hay otro que es interp en lugar de flat que lo suaviza mas aun)
shading interp
datetick('x','dd'); %esto tu no lo pones, porque no tienes tiempo en el eje x. para ver cómo se ponen las etiquetas, vete al otro que te pasé, al de cris
% xlim([dateN_I01(1)-0.008 dateN_I01(end)+0.08]); %esto no hace falta, es para eliminar huecos en blanco alrededor del gráfico. lo ajustas al valor máximo y mínimo de tus variables x e y
% ylim([-34.5 0]);

ylabel('Depth (m)'); %nombre de los ejes
xlab=xlabel('days');
title ('Winter TIN');

colormap('jet');
caxis([0 10]);  % masximos y minomos de la escala

hold on; %para superponer los puntos donde se cogió muestra de agua para medir nitrato:
scatter(dateWN(isfinite(TINW)),-depthW(isfinite(TINW)),20,TINW(isfinite(TINW)),'o','filled','MarkerEdgeColor',[.6 .6 .6],'LineWidth',1);
