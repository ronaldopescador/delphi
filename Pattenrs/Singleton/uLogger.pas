unit uLogger;

interface

type
  TLogger = class
  private
    class var FInstance: TLogger;
    class var FLock: TObject;
    constructor Create;
  public
    procedure Write(_AMessage: String);
    class function GetInstance: TLogger;
    class procedure DestroyInstance;
  end;

implementation

uses
  System.SysUtils;

{ TLogger }

constructor TLogger.Create;
begin
  inherited Create;

end;

class procedure TLogger.DestroyInstance;
begin
  TMonitor.Enter(TLogger.FLock);
  try
    FreeAndNil(FInstance);
  finally
    TMonitor.Exit(TLogger.FLock);
  end;
end;

class function TLogger.GetInstance: TLogger;
begin
  if FInstance = nil then
  begin
    TMonitor.Enter(TLogger.FLock);
    try
      if FInstance = nil then
        FInstance := TLogger.Create;
    finally
      TMonitor.Exit(TLogger.FLock);
    end;
  end;

  Result := FInstance;
end;

procedure TLogger.Write(_AMessage: String);
begin
  Writeln(_AMessage);
end;

initialization
  TLogger.FLock := TObject.Create;

finalization
  TLogger.DestroyInstance;
  FreeAndNil(TLogger.FLock);

end.
