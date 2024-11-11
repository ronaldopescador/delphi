program Singleton;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uLogger in 'uLogger.pas';

begin
  ReportMemoryLeaksOnShutdown := True;
  try
    TLogger.GetInstance.Write('Sucesso!');
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
