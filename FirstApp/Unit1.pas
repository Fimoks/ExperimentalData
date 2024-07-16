﻿unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdCoder, IdCoder3to4,
  IdCoderMIME, IdMessage, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdTCPServer, IdCmdTCPServer, IdExplicitTLSClientServerBase, IdSMTPServer,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTPBase, IdSMTP,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSLOpenSSL, IdSSL,
  Vcl.ExtCtrls, IdAttachment,IdMessageParts, IdIMAP4, IdPOP3;
type
  TForm1 = class(TForm)
    Button1: TButton;
    IdMessage1: TIdMessage;
    IdSMTP1: TIdSMTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    ListBox1: TListBox;
    Timer1: TTimer;
    IdIMAP41: TIdIMAP4;
    IdEncoderMIME1: TIdEncoderMIME;
    IdPOP31: TIdPOP3;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.Button1Click(Sender: TObject);  // отправление запроса
begin

Timer1.Enabled := True;
IdSMTP1.Host:='smtp.mail.ru';
IdSMTP1.Port:=465;
IdSMTP1.UserName:='kpfukursovaya@mail.ru';
IdSMTP1.Password:='k2zFHTpa8RCM6B37pMtc';
IdSMTP1.AuthType := satDefault;
IdSMTP1.ConnectTimeout:=10000;
IdSMTP1.IOHandler:=IdSSLIOHandlerSocketOpenSSL1;
IdSMTP1.UseTLS:=utUseExplicitTLS;
IdSSLIOHandlerSocketOpenSSL1.Destination := IdSMTP1.Host+':'+IntToStr(IdSMTP1.Port);
IdSSLIOHandlerSocketOpenSSL1.Host := IdSMTP1.Host;
IdSSLIOHandlerSocketOpenSSL1.Port := IdSMTP1.Port;
IdSSLIOHandlerSocketOpenSSL1.DefaultPort := 0;
IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Method := sslvSSLv23;
IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Mode := sslmUnassigned;

ListBox1.Items.Add('Пробуем подключиться');
IdSMTP1.Connect;
if IdSMTP1.Connected then
  begin
  ListBox1.Items.Add('Вошли');
  idmessage1.IsEncoded:=true;
  idmessage1.ContentType := 'text/plain; charset=UTF-8';
  IdMessage1.Body.Text:='hello';
  IdMessage1.Subject:='Zapros';
  IdMessage1.From.Text:='kpfukursovaya@mail.ru';
  IdMessage1.Recipients.EMailAddresses:='kpfukursovaya2@mail.ru';
  IdSMTP1.Send(IdMessage1);
  ListBox1.Items.Add('Запрос успешно отправлен на ПК2');
  IdSMTP1.Disconnect();
  end;
end;



procedure TForm1.Timer1Timer(Sender: TObject);   //скачиваные файла с данными
var
    i: Integer;
    xAttach: TIdAttachment;
    msg1: Integer;

begin

idPOP31.Username:='kpfukursovaya@mail.ru';
idPOP31.Password:='k2zFHTpa8RCM6B37pMtc';
idPOP31.Host:='pop.mail.ru';

IdPOP31.IOHandler:=IdSSLIOHandlerSocketOpenSSL1;
IdPOP31.UseTLS:=utUseExplicitTLS;
IdSSLIOHandlerSocketOpenSSL1.Destination := IdPOP31.Host+':'+IntToStr(IdPOP31.Port);
IdSSLIOHandlerSocketOpenSSL1.Host := IdPOP31.Host;
IdSSLIOHandlerSocketOpenSSL1.Port := IdPOP31.Port;
IdSSLIOHandlerSocketOpenSSL1.DefaultPort := 0;
IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Method := sslvSSLv23;
IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Mode := sslmUnassigned;

idPOP31.Connect();
msg1:=idPOP31.CheckMessages;
ListBox1.Items.Add('У вас '+IntToStr(msg1)+' сообщений');
i:= IdMessage1.MessageParts.Count;

idPOP31.Retrieve(msg1,idMessage1);
for i := 0 to IdMessage1.MessageParts.Count - 1 do
    begin
       if IdMessage1.MessageParts.Items[i] is TIdAttachment then
          begin
         (idMessage1.MessageParts.Items[i] as TIdAttachment).SaveToFile('D:\Course work');
          ListBox1.Items.Add('Файл с эксперементальными данными скачан');
          IdPOP31.Delete(msg1);
          end;
    end;
idPOP31.Disconnect();
Timer1.Enabled := False;
end;
end.