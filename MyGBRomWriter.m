clear;clc;close all;

rom = uint8(zeros(1,32767));
rom(hex2dec('101')+1) = hex2dec('C3');
rom(hex2dec('102')+1) = hex2dec('50');
rom(hex2dec('103')+1) = hex2dec('01');
PC = hex2dec('150');
code = {'LD H,0x80',... %(8000) <- 3C
        'LD L,0x00',...
        'LD (HL),0x3C',...
        'LD H,0x80',... %(8001) <- 3C
        'LD L,0x01',...
        'LD (HL),0x3C',...
        'LD H,0x80',... %(8002) <- 42
        'LD L,0x02',...
        'LD (HL),0x7E',...
        'LD H,0x80',... %(8003) <- 7E
        'LD L,0x03',...
        'LD (HL),0x42',...
        'LD H,0x80',... %(8004) <- A5
        'LD L,0x04',...
        'LD (HL),0xFF',...
        'LD H,0x80',... %(8005) <- FF
        'LD L,0x05',...
        'LD (HL),0xA5',...
        'LD H,0x80',... %(8006) <- 81
        'LD L,0x06',...
        'LD (HL),0xFF',...
        'LD H,0x80',... %(8007) <- FF
        'LD L,0x07',...
        'LD (HL),0x81',...       
        'LD H,0x80',... %(8008) <- FF
        'LD L,0x08',...
        'LD (HL),0xFF',...
        'LD H,0x80',... %(8009) <- A5
        'LD L,0x09',...
        'LD (HL),0xA5',... 
        'LD H,0x98',... %(9800) <- 00
        'LD L,0x00',...
        'LD (HL),0x00',...
        'JP 0x0100'};
for i = 1:length(code)
    if strcmp(code{i}(1:4),'LD B')
        rom(PC+1) = hex2dec('06');
        data = code{i}(6:end);
        if strcmp(data(1:2),'0x')
            rom(PC+2) = hex2dec(data(3:end));
        elseif strcmp(data(1:2),'0b')
            rom(PC+2) = bin2dec(data(3:end));
        end
        PC = PC+2;
    elseif strcmp(code{i}(1:4),'LD H')
        rom(PC+1) = hex2dec('26');
        data = code{i}(6:end);
        if strcmp(data(1:2),'0x')
            rom(PC+2) = hex2dec(data(3:end));
        elseif strcmp(data(1:2),'0b')
            rom(PC+2) = bin2dec(data(3:end));
        end
        PC = PC+2;
    elseif strcmp(code{i}(1:4),'LD L')
        rom(PC+1) = hex2dec('2E');
        data = code{i}(6:end);
        if strcmp(data(1:2),'0x')
            rom(PC+2) = hex2dec(data(3:end));
        elseif strcmp(data(1:2),'0b')
            rom(PC+2) = bin2dec(data(3:end));
        end
        PC = PC+2;
    elseif strcmp(code{i}(1:7),'LD (HL)')
        rom(PC+1) = hex2dec('36');
        data = code{i}(9:end);
        if strcmp(data(1:2),'0x')
            rom(PC+2) = hex2dec(data(3:end));
        elseif strcmp(data(1:2),'0b')
            rom(PC+2) = bin2dec(data(3:end));
        end
        PC = PC+2;
    elseif strcmp(code{i}(1:2),'JP')
        rom(PC+1) = hex2dec('C3');
        adr = code{i}(4:end);
        if strcmp(adr(1:2),'0x')
            rom(PC+3) = hex2dec(adr(3:4));
            rom(PC+2) = hex2dec(adr(5:6));
        elseif strcmp(data(1:2),'0b')
            rom(PC+3) = bin2dec(adr(3:10));
            rom(PC+2) = bin2dec(adr(11:18));
        end
        PC = PC + 3;
    end
end
    
fid = fopen('rom.gb','w');
fwrite(fid,rom);
fclose(fid);