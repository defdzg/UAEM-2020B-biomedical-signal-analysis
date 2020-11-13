clc; clear all; close all;

%% Parte 2: @Daniel
% Ve a la p�gina de https://physionet.org/content/chbmit/1.0.0/ y descarga una se�al de EEG.
% a) Grafica los primeros 2 segundos de la se�al. Muestra la gr�fica (tiempo vs. volts)
[hdr, record] = edfread('data/chb01_01.edf'); %edfread es una funci�n utilizada para leer la se�al
n = length(record); fs = 256; T = 1/fs; 
t=0:T:(n/fs)-T;

% Gr�fica de todas las se�ales s�lo en una figura
figure
for i = 1:size(record,2)
    plot(t(1:2/T),record(1:2/T,i))
    hold on
end
ylabel('Voltaje [uV]');
xlabel('Tiempo [s]');
title('EEG: chb01-01.edf');

    % Gr�fica de cada canal en diferentes subplot
    % for i = 1:size(record,2)
    %     subplot(23,1,i)
    %     plot(t(1:2/T),record(1:2/T,i))
    % %     Units are hidden just for aesthetic
    % %     ylabel('Voltage [uV]');
    % %     xlabel('Time [s]');   
    % end
    % suptitle('chb01-01.edf');
    % segmentos = struct();
    % promedio_eeg = struct();

% b) Segmenta los primeros 20 segundos de la se�al (en segmentos de 2 segundos cada uno). 
% Tendr�s en total 10 segmentos. 
% c) Calcula la FFT de los 10 segmentos     
x = 1;
for i = 2:2:20
    a = strcat('s',num2str(x));
    if i == 2
    segmentos.(a) = record(1:(i/T)+1,:); %Segmentaci�n en ventanas de 2 segundos
    else
    segmentos.(a) = record(i/T:(i+2)/T,:); %Segmentaci�n en ventanas de 2 segundos
    end
    promedio_eeg.(a) = mean(segmentos.(a),2); %Promedio de los 23 canales del EEG
    ftrans.(a) = abs(fft(promedio_eeg.(a),[],1)); %FFT de la se�al promediada
    x = x+1;
end
for x = 1:10 %Transformaci�n de struct a array para operaciones
    a = strcat('s',num2str(x));
    ftrans_a(:,x) = ftrans.(a);
end
% d) Promedia el espectro de todos los segmentos
figure
frans_prom = mean(ftrans_a,2); %Promedio del espectro de las potencias
frans_prom = frans_prom/1000; %Transformando de uV a V
L = length(frans_prom);
P2 = abs(frans_prom/L);
P1 = frans_prom(1:length(frans_prom)/2+1);   % Espectro de potencia s�lo de un lado
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(L/2))/L;
plot(f,P1) 
title('Promedio de los espectros del EEG: chb01-01.edf')
xlabel('Frecuencia [Hz]')
ylabel('Potencia')

% e) Contesta �qu� se observa del promedio de los espectros !FALTANTE
% Comprobar resultados de unidades del espectro de potencia en las gr�ficas
% generadas en comparaci�n a la presentada en:
% web('https://raphaelvallat.com/images/tutorials/bandpower/psd_area.png')

%% (S�lo adjuntar un archivo .m como reporte de la pr�ctica)

%% Funci�n para leer archivos *.EDF
function [hdr, record] = edfread(fname, varargin)
% Read European Data Format file into MATLAB
%
% [hdr, record] = edfRead(fname)
%         Reads data from ALL RECORDS of file fname ('*.edf'). Header
%         information is returned in structure hdr, and the signals
%         (waveforms) are returned in structure record, with waveforms
%         associated with the records returned as fields titled 'data' of
%         structure record.
%
% [...] = edfRead(fname, 'assignToVariables', assignToVariables)
%         Triggers writing of individual output variables, as defined by
%         field 'labels', into the caller workspace.
%
% FORMAT SPEC: Source: http://www.edfplus.info/specs/edf.html SEE ALSO:
% http://www.dpmi.tu-graz.ac.at/~schloegl/matlab/eeg/edf_spec.htm
%
% The first 256 bytes of the header record specify the version number of
% this format, local patient and recording identification, time information
% about the recording, the number of data records and finally the number of
% signals (ns) in each data record. Then for each signal another 256 bytes
% follow in the header record, each specifying the type of signal (e.g.
% EEG, body temperature, etc.), amplitude calibration and the number of
% samples in each data record (from which the sampling frequency can be
% derived since the duration of a data record is also known). In this way,
% the format allows for different gains and sampling frequencies for each
% signal. The header record contains 256 + (ns * 256) bytes.
%
% Following the header record, each of the subsequent data records contains
% 'duration' seconds of 'ns' signals, with each signal being represented by
% the specified (in the header) number of samples. In order to reduce data
% size and adapt to commonly used software for acquisition, processing and
% graphical display of polygraphic signals, each sample value is
% represented as a 2-byte integer in 2's complement format. Figure 1 shows
% the detailed format of each data record.
%
% DATA SOURCE: Signals of various types (including the sample signal used
% below) are available from PHYSIONET: http://www.physionet.org/
%
%
% % EXAMPLE 1:
% % Read all waveforms/data associated with file 'ecgca998.edf':
%
% [header, recorddata] = edfRead('ecgca998.edf');
%
% % EXAMPLE 2:
% % Read records 3 and 5, associated with file 'ecgca998.edf':
%
% header = edfRead('ecgca998.edf','AssignToVariables',true);
% % Header file specifies data labels 'label_1'...'label_n'; these are
% % created as variables in the caller workspace.
%
% Coded 8/27/09 by Brett Shoelson, PhD
% brett.shoelson@mathworks.com
% Copyright 2009 - 2012 MathWorks, Inc.

% HEADER RECORD
% 8 ascii : version of this data format (0)
% 80 ascii : local patient identification
% 80 ascii : local recording identification
% 8 ascii : startdate of recording (dd.mm.yy)
% 8 ascii : starttime of recording (hh.mm.ss)
% 8 ascii : number of bytes in header record
% 44 ascii : reserved
% 8 ascii : number of data records (-1 if unknown)
% 8 ascii : duration of a data record, in seconds
% 4 ascii : number of signals (ns) in data record
% ns * 16 ascii : ns * label (e.g. EEG FpzCz or Body temp)
% ns * 80 ascii : ns * transducer type (e.g. AgAgCl electrode)
% ns * 8 ascii : ns * physical dimension (e.g. uV or degreeC)
% ns * 8 ascii : ns * physical minimum (e.g. -500 or 34)
% ns * 8 ascii : ns * physical maximum (e.g. 500 or 40)
% ns * 8 ascii : ns * digital minimum (e.g. -2048)
% ns * 8 ascii : ns * digital maximum (e.g. 2047)
% ns * 80 ascii : ns * prefiltering (e.g. HP:0.1Hz LP:75Hz)
% ns * 8 ascii : ns * nr of samples in each data record
% ns * 32 ascii : ns * reserved

% DATA RECORD
% nr of samples[1] * integer : first signal in the data record
% nr of samples[2] * integer : second signal
% ..
% ..
% nr of samples[ns] * integer : last signal

if nargin > 3
    error('EDFREAD: Too many input arguments.');
end

if ~nargin
    [fname] = uigetfile({'*.edf','European Data Format Files'});
if ~iscell(fname)
    if length(fname) <= 1 && fname == 0
        return;
    end
end

end

if nargin == 1
    assignToVariables = false;
end

[fid,msg] = fopen(fname,'r');
if fid == -1
    error(msg)
end

assignToVariables = false; %Default
for ii = 1:2:numel(varargin)
    switch lower(varargin{ii})
        case 'assigntovariables'
            assignToVariables = varargin{ii+1};
    end
end

% HEADER
hdr.ver        = str2double(char(fread(fid,8)'));
hdr.patientID  = fread(fid,80,'*char')';
hdr.recordID   = fread(fid,80,'*char')';
hdr.startdate  = fread(fid,8,'*char')';% (dd.mm.yy)
% hdr.startdate  = datestr(datenum(fread(fid,8,'*char')','dd.mm.yy'), 29); %'yyyy-mm-dd' (ISO 8601)
hdr.starttime  = fread(fid,8,'*char')';% (hh.mm.ss)
% hdr.starttime  = datestr(datenum(fread(fid,8,'*char')','hh.mm.ss'), 13); %'HH:MM:SS' (ISO 8601)
hdr.bytes      = str2double(fread(fid,8,'*char')');
reserved       = fread(fid,44);
hdr.records    = str2double(fread(fid,8,'*char')');
hdr.duration   = str2double(fread(fid,8,'*char')');
% Number of signals
hdr.ns    = str2double(fread(fid,4,'*char')');
for ii = 1:hdr.ns
    hdr.label{ii} = fread(fid,16,'*char')';
end
for ii = 1:hdr.ns
    hdr.transducer{ii} = fread(fid,80,'*char')';
end
% Physical dimension
for ii = 1:hdr.ns
    hdr.units{ii} = fread(fid,8,'*char')';
end
% Physical minimum
for ii = 1:hdr.ns
    hdr.physicalMin(ii) = str2double(fread(fid,8,'*char')');
end
% Physical maximum
for ii = 1:hdr.ns
    hdr.physicalMax(ii) = str2double(fread(fid,8,'*char')');
end
% Digital minimum
for ii = 1:hdr.ns
    hdr.digitalMin(ii) = str2double(fread(fid,8,'*char')');
end
% Digital maximum
for ii = 1:hdr.ns
    hdr.digitalMax(ii) = str2double(fread(fid,8,'*char')');
end
for ii = 1:hdr.ns
    hdr.prefilter{ii} = fread(fid,80,'*char')';
end
for ii = 1:hdr.ns
    hdr.samples(ii) = str2double(fread(fid,8,'*char')');
end
for ii = 1:hdr.ns
    reserved    = fread(fid,32,'*char')';
end
hdr.label = deblank(hdr.label);
hdr.units = deblank(hdr.units);


if nargout > 1 || assignToVariables
    % Scale data (linear scaling)
% %     scalefac = (hdr.physicalMax - hdr.physicalMin)./(hdr.digitalMax - hdr.digitalMin);
% %     dc = hdr.physicalMax - scalefac .* hdr.digitalMax;
% %     
    % RECORD DATA REQUESTED
    tmpdata = struct;
    for recnum = 1:hdr.records
        for ii = 1:hdr.ns
            % Use a cell array for DATA because number of samples may vary
            % from sample to sample
            tmpdata(recnum).data{ii} = fread(fid,hdr.samples(ii),'int16');% * scalefac(ii) + dc(ii);
        end
    end
    record = zeros(hdr.samples(1)*hdr.records, hdr.ns);
    
    for ii = 1:numel(hdr.label)
        ctr = 1;
        for jj = 1:hdr.records
            try
                record(ctr : ctr + hdr.samples - 1, ii) = tmpdata(jj).data{ii};
            catch exception
                if length(tmpdata(jj).data{ii}) ~= hdr.samples(ii)
                    record(ctr : ctr + length(tmpdata(jj).data{ii}) - 1, ii) = tmpdata(jj).data{ii};
                else
                    throw(exception);
                end
            end
            ctr = ctr + hdr.samples;
        end
    end
    
    if assignToVariables
        for ii = 1:numel(hdr.label)
            try
                eval(['assignin(''caller'',''',hdr.label{ii},''',record(ii,:))'])
            end
        end
    end
end
fclose(fid);
end