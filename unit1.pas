unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, ColorBox;

type
  CompInfo=record
    index,top,left,width,height,fontsize:integer;
  end;
  complist=array of CompInfo;

  { TForm1 }

  TForm1 = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    btnRestart: TButton;
    ChangeColor: TColorBox;
    Capybara: TImage;
    StopWatch: TLabel;
    StopwatchTimer: TTimer;
    procedure btnRestartClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure ChangeColorChange(Sender: TObject);
    procedure CapybaraClick(Sender: TObject);
    procedure StopwatchTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { private declarations }
    DefWidth,defHeight:integer;
    clist:complist;
  public
    { public declarations }

  end;

var
  Form1: TForm1;

implementation
uses math;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
begin
  defwidth:=width;
  defheight:=height;
  for i:= 0 to ComponentCount-1 do
    if (Components[i].Classname = 'TRadioButton')
    or (Components[i].Classname ='TCheckBox')
    or (Components[i].Classname ='TButton')
    or (Components[i].Classname ='TBitBtn')
    or (Components[i].Classname ='TSpeedButton')
    or (Components[i].Classname ='TColorBox')
    or (Components[i].Classname ='TImage')
    or (Components[i].Classname ='TEdit')
    or (Components[i].Classname ='TRadioGroup')
    or (Components[i].Classname ='TCheckGroup')
    or (Components[i].Classname ='TListBox')
    or (Components[i].Classname ='TComboBox')
    or (Components[i].Classname ='TEdit')
    or (Components[i].Classname ='TSpinEdit')
    or (Components[i].Classname ='TLabel') then begin
      setlength(clist,Length(clist)+1);
      clist[Length(clist)-1].top:=(Components[i] as tcontrol).top;
      clist[Length(clist)-1].left:=(Components[i]as tcontrol).left;
      clist[Length(clist)-1].width:=(Components[i] as tcontrol).width;
      clist[Length(clist)-1].height:=(Components[i]as tcontrol).height;
      clist[Length(clist)-1].fontsize:=(Components[i]as tcontrol).font.Size;
      clist[Length(clist)-1].index:=i;
    end;
end;

procedure TForm1.FormResize(Sender: TObject);
var i:integer;
begin
  if width >1000 then width:=800;
  if width<150   then width:=250;
  if height>800 then height:=800;
  if height<150 then height:=250;
  For i:=0 to length(clist)-1 do begin
    (components[clist[i].index] as tcontrol).Top:=round(clist[i].top*height/defheight);
    (components[clist[i].index] as tcontrol).height:=round(clist[i].height*height/defheight);
    (components[clist[i].index] as tcontrol).left:=round(clist[i].left*width/defwidth);
    (components[clist[i].index] as tcontrol).width:=round(clist[i].width*width/defwidth);
    (components[clist[i].index] as tcontrol).font.Size:=round(clist[i].fontsize*min(width/defwidth,height/defheight));
  end;
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  StopwatchTimer.Enabled := True;
end;

procedure TForm1.btnRestartClick(Sender: TObject);
begin
  StopwatchTimer.Enabled := False;
  StopwatchTimer.Interval := 1000;
  StopWatch.Caption := '00:00:00';
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  StopwatchTimer.Enabled := False;
end;

procedure TForm1.ChangeColorChange(Sender: TObject);
begin
     Form1.Color := ChangeColor.Selected;
end;

procedure TForm1.CapybaraClick(Sender: TObject);
begin

end;

procedure TForm1.StopwatchTimerTimer(Sender: TObject);
var
  H, M, S: Integer;
  ElapsedTime: Integer;
begin
  ElapsedTime := 0;
  S := StrToInt(StopWatch.Caption[7]+StopWatch.Caption[8]);
  M := StrToInt(StopWatch.Caption[4]+StopWatch.Caption[5]);
  H := StrToInt(StopWatch.Caption[1]+StopWatch.Caption[2]);
  S += 1;
  ElapsedTime += 1;
  if ElapsedTime = 10 then
  begin
       Capybara := TImage.Create(Form1);
       Capybara.Parent := Form1;
       Capybara.Width := Form1.ClientWidth;
       Capybara.Height := Form1.ClientHeight;
       Capybara.Picture.LoadFromFile('capybara.jpg');
  end;
  if S = 60 then
  begin
    S := 0;
    M += 1;
    if M = 60 then
    begin
      M := 0;
      H += 1;
    end;
  end;
  StopWatch.Caption := Format('%.2d:%.2d:%.2d', [H, M, S]);
end;

end.

