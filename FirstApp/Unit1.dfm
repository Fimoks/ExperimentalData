object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 506
  ClientWidth = 391
  Color = clMedGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object Button1: TButton
    Left = 80
    Top = 56
    Width = 241
    Height = 117
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1079#1072#1087#1088#1086#1089
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 80
    Top = 216
    Width = 241
    Height = 237
    Color = clScrollBar
    ItemHeight = 13
    TabOrder = 1
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 80
  end
  object IdSMTP1: TIdSMTP
    AuthType = satSASL
    SASLMechanisms = <>
    Left = 8
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 192
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 16
    Top = 88
  end
  object IdIMAP41: TIdIMAP4
    SASLMechanisms = <>
    MilliSecsToWaitToClearBuffer = 10
    Left = 328
  end
  object IdEncoderMIME1: TIdEncoderMIME
    FillChar = '='
    Left = 400
  end
  object IdPOP31: TIdPOP3
    SASLMechanisms = <>
    Left = 496
  end
end