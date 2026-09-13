
clear
close all

winter = xlsread('All_Metadata.xlsx');

dateV_I01 = date(1:i01,:);
dateV_I02 = date(i01+1:i02,:);
dateV_I03 = date(i02+1:end,:); % tengo todo repetido 3 veces porque son 3 leg distintos, pero tú solo fijate en el I01 que es el muestreo intensivo 1

dateN_I01=datenum(dateV_I01);
dateN_I02=datenum(dateV_I02);
dateN_I03=datenum(dateV_I03);
dateN_I01=[dateN_I01; dateN_I01(end,:)+0.005];
dateN_I02=[dateN_I02; dateN_I02(end,:)+0.005];
dateN_I03=[dateN_I03; dateN_I03(end,:)+0.005];
%las lineas anteriores no te valen de nada, ya que son tiempo, tu tienes
%distancia, no tienes que transformar la variable como hago yo usando
%datenum, pero te lo dejo para que veas el resultado

figure()
%%%%%% nitrate %%%%%%

%defino tamaño de hoja (no tienes por qué hacer esto, podrias borrar hasta
%la linea 42 (incluida)
set(gcf,'PaperUnits','centimeters');
xSize=21;
ySize=4.5;
xLeft=(21-xSize)/2;
yTop=(4.5-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize]);
set(gcf,'Position',[xLeft yTop xSize*50 ySize*50]);
set(gcf,'color',[1 1 1]);

xt=1.05/xSize;
yt=1/ySize;
wt=(7.558-.5)/xSize; %18.4 total
ht=3.2/ySize;
axes('position',[xt yt wt ht]);

load nutrients_remedios_cruise.mat %cargo mis datos, que en este caso los tengo en .mat en lugar de excel

i0F(1)=find(cruise==1,1,'first'); %esto es por lod e los distintos leg, a ti no te haría falta tampoco nada de esto
j0F(1)=find(cruise==1,1,'last');
i0F(2)=find(cruise==2,1,'first');
j0F(2)=find(cruise==2,1,'last');
i0F(3)=find(cruise==3,1,'first');
j0F(3)=find(cruise==3,1,'last');

time=nan(size(cruise));

for i=1:length(cruise)
    time(i)=(datenum(date(i,:))-datenum(date(i0F(cruise(i)),:)))*24;
end

%Datos reales para cada ciclo intensivo

%Tiempo
time1=time(i0F(1):j0F(1));
time2=time(i0F(2):j0F(2));
time3=time(i0F(3):j0F(3));

%Fecha
date1=date(i0F(1):j0F(1),:);
date2=date(i0F(2):j0F(2),:);
date3=date(i0F(3):j0F(3),:);

%fecha matlab
date1_Vn=datenum(date1);
date2_Vn=datenum(date2);
date3_Vn=datenum(date3);

%Presi�n
pres1=pres(i0F(1):j0F(1));
pres2=pres(i0F(2):j0F(2));
pres3=pres(i0F(3):j0F(3));

%Nitrato
NO3_1=NO3(i0F(1):j0F(1));
NO3_2=NO3(i0F(2):j0F(2));
NO3_3=NO3(i0F(3):j0F(3));
    m_NO3=min(min(NO3));
    M_NO3=max(max(NO3));

    %lo que viene despues tiene que ver con el tiempo. todo lo que ponga
    %date o time, es un rollo y en principio no te hace falta. lo dejo para
    %que puedas visualizar el resultado.

%Siempre que estemos en el mismo perfil la resta de un elemento de tiempo y el anterior ser� un n�mero igual a cero. Si no es 0 tendremos un cambio de perfil
kk_t1 = find(time1(2:end,1)-time1(1:end-1,1)~=0);
kk_t1=[kk_t1;length(time1)];
date_1= date(kk_t1,:);
date1_Vn_d=date1_Vn(kk_t1,:); %días en los que se muestreo. I01 -> SE MUESTREO 8 dias

kk_t2 = find(time2(2:end,1)-time2(1:end-1,1)~=0);
kk_t2=[kk_t2;length(time2)];
date_2= date2(kk_t2,:);
date2_Vn_d=date2_Vn(kk_t2,:); % se muestreo 2 dias en el i2

kk_t3 = find(time3(2:end,1)-time3(1:end-1,1)~=0);
kk_t3=[kk_t3;length(time3)];
date_3= date3(kk_t3,:);
date3_Vn_d=date3_Vn(kk_t3,:); %se muestreo 9 dias en el i3

date01 = datenum(date1(1,:));
dates01 = (datenum(date1(8,:)):1/2:datenum(date1(end,:)));
xtick_tick1 = (dates01-date01)*24;
xtick_dateL1 = datevec(dates01);

date02 = datenum(date2(1,:));
dates02 = (datenum(date2(1,:)):1/2:datenum(date2(end,:)));
xtick_tick2 = (dates02-date02)*24;
xtick_dateL2 = datevec(dates02);

date03 = datenum(date3(1,:));
dates03 = (datenum(date3(1,:)):1/2:datenum(date3(end,:)));
xtick_tick3 = (dates03-date03)*24;
xtick_dateL3 = datevec(dates03);

% %interpolaci�n   de la variable x
dateINT1=[linspace(min(date1_Vn),max(date1_Vn),25)];%aquí empezarías tú, tendrías que poner tu variable x, que es distancia, no sé si lo tienes en longitud, imagino que si
dateINT2=[linspace(min(date2_Vn),max(date2_Vn),4)]; %el date 2 y 3 no te hace falta, tú solo leerías la primera linea de todas las cosas que tengo aqui escritas
dateINT3=[linspace(min(date3_Vn),max(date3_Vn),25)];

presINT=(1:2.5:35)'; %creas tu variable profundidad según la prof maxima de tus estaciones. Por ejemplo si tu profundidad máxima es 100, pues creas la variable pres cada metro por ejemplo d ela siguiente forma: pres=(0:1:100)';

[x1d,y1d]=meshgrid(dateINT1,presINT); %creas una malla usando tu variable x (distancia) y tu variable y (profundidad)
[x2d,y2d]=meshgrid(dateINT2,presINT);
[x3d,y3d]=meshgrid(dateINT3,presINT);

NO3_INT_1=gridfit(date1_Vn(isfinite(NO3_1)),pres1(isfinite(NO3_1)),NO3_1(isfinite(NO3_1)),x1d(1,:),y1d(:,1)); %interpolas tu variable, en este caso el nitrato, sobre la malla que acabas de crear (yo le llame x1d e y1d al a malla)
NO3_INT_2=gridfit(date2_Vn(isfinite(NO3_2)),pres2(isfinite(NO3_2)),NO3_2(isfinite(NO3_2)),x2d(1,:),y2d(:,1));
NO3_INT_3=gridfit(date3_Vn(isfinite(NO3_3)),pres3(isfinite(NO3_3)),NO3_3(isfinite(NO3_3)),x3d(1,:),y3d(:,1));

NO3_INT_1(NO3_INT_1<0)=0; %elimino posibles valores erróneos que sean negativos
NO3_INT_2(NO3_INT_2<0)=0;
NO3_INT_3(NO3_INT_3<0)=0;
NO3_INT=[NO3_INT_1,NO3_INT_2,NO3_INT_3];

%%%%INTENSIVO 1
dateINT1 = [dateINT1,dateINT1(1,end)]; %repites el úlitmo valor de tiempo, ya que la función pcolor lo elimina, no sé por qué. Si tienes muchismos perfiles no se nota, pero si tienes poquitos es mejor que lo repitas como está puesto aquí
NO3_INT_1 = [NO3_INT_1,NO3_INT_1(:,end)]; %lo mismo con el nitrato


pcolor(dateINT1,-presINT,NO3_INT_1); %representas tu variable. primero colocas x(en mi caso date, que es el tiempo), luego y (en mi caso la presión en negativo) y luego tu variable de color (mi caso nitrato)
shading flat; %esto es para que no te pinte una malla de cuadrados negros, así se ve más fluido el gráfico (hay otro que es interp en lugar de flat que lo suaviza mas aun)
datetick('x','dd'); %esto tu no lo pones, porque no tienes tiempo en el eje x. para ver cómo se ponen las etiquetas, vete al otro que te pasé, al de cris
xlim([dateN_I01(1)-0.008 dateN_I01(end)+0.08]); %esto no hace falta, es para eliminar huecos en blanco alrededor del gráfico. lo ajustas al valor máximo y mínimo de tus variables x e y
ylim([-34.5 0]);

ylabel('pressure (dbar)'); %nombre de los ejes
xlab=xlabel('July (days)');
set(xlab,'Position',[dateN_I01(end,1)+1 -39]); %estto puedes borrarlo

map3=cmocean('matter'); %esta función es para escoger el color, igual que la que te pase de brewermap. son colores típicos en los plots del océano
colormap(map3);
caxis([m_NO3 M_NO3]);

hold on; %para superponer los puntos donde se cogió muestra de agua para medir nitrato:
scatter(date1_Vn(isfinite(NO3_1)),-pres1(isfinite(NO3_1)),20,NO3_1(isfinite(NO3_1)),'o','filled','MarkerEdgeColor',[.6 .6 .6],'LineWidth',1);

%%% aqui ya emepzaría el intensivo 2, que es lo mismo que antes. puedes
%%% saltártelo y ver directamente el 3, donde se pone la barra de color
xt=(8.908-.5)/xSize; %1.05+7.558+0.4
yt=1/ySize;
wt=(2.749-.5)/xSize; %18.4 total
ht=3.2/ySize;
axes('position',[xt yt wt ht]);

NO3_INT_2 = [NO3_INT_2,NO3_INT_2(:,end)];
dateINT2= [dateINT2,dateINT2(1,end)];

pcolor(dateINT2,-presINT,NO3_INT_2);
shading flat;
datetick('x','dd');
xlim([dateN_I02(1,1)-0.005 dateN_I02(end)+0.005]);
ylim([-34.5 0]);

set(gca,'Yticklabel',[]);
map3=cmocean('matter');
colormap(map3);
caxis([m_NO3 M_NO3]);

hold on;
% scatter(time2(isfinite(NO3_2)),-pres2(isfinite(NO3_2)),SsNO3(i0F(2):j0F(2)),NO3_2(isfinite(NO3_2)),'o','filled','MarkerEdgeColor',[.6 .6 .6],'LineWidth',1);
scatter(date2_Vn(isfinite(NO3_2)),-pres2(isfinite(NO3_2)),20,NO3_2(isfinite(NO3_2)),'o','filled','MarkerEdgeColor',[.6 .6 .6],'LineWidth',1);


%%%%%INTENSIVO 3
xt=(11.957-1)/xSize; %9.008+2.749+0.4
yt=1/ySize;
wt=(7.293-.5)/xSize; %18.4 total
ht=3.2/ySize;
axes('position',[xt yt wt ht]);

NO3_INT_3 = [NO3_INT_3,NO3_INT_3(:,end)];
dateINT3 = [dateINT3,dateINT3(1,end)];

pcolor(dateINT3,-presINT,NO3_INT_3);
shading flat;
datetick('x','dd');
xlim([dateN_I03(1,1)-0.005 dateN_I03(end)+0.02]);
ylim([-34.5 0]);

set(gca,'Yticklabel',[]);
map3=cmocean('matter');
colormap(map3);
caxis([m_NO3 M_NO3]);

hold on;
% scatter(time3(isfinite(NO3_3)),-pres3(isfinite(NO3_3)),SsNO3(i0F(3):j0F(3)),NO3_3(isfinite(NO3_3)),'o','filled','MarkerEdgeColor',[.6 .6 .6],'LineWidth',1);
scatter(date3_Vn(isfinite(NO3_3)),-pres3(isfinite(NO3_3)),20,NO3_3(isfinite(NO3_3)),'o','filled','MarkerEdgeColor',[.6 .6 .6],'LineWidth',1);


xc=(19.6-1.5)/xSize;
yc=1/ySize;
wc=0.5/xSize;
hc=3.2/ySize;

c=colorbar;
label=ylabel(c,'nitrate (\muM)');
set(c,'Position',[xc yc wc hc]);

supersizeme(1.7);
supersizeme(label,2)
