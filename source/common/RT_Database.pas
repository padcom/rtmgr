unit RT_Database;

interface

uses
  Classes, SysUtils, Contnrs;

type
  TTaxiList = class;
  TStreet = class;

  IObserver = interface
    ['{7A891E6A-BB65-483F-9272-35BFEE32F578}']
    procedure Notify(Sender: TObject; Subject: TObject; Params: array of const);
  end;

  IDisableable = interface
    ['{A525D5D2-E07C-4A93-B9DD-25F15CB8D0E7}']
    function GetIsEnabled: Boolean;
    procedure Enable;
    procedure Disable;
    property IsEnabled: Boolean read GetIsEnabled;
  end;

  TObserverList = class (TInterfaceList)
  private
    function GetItem(Index: Integer): IObserver;
  public
    procedure Register(Observer: IObserver);
    procedure Unregister(Observer: IObserver);
    procedure Notify(Sender: TObject; Subject: TObject; Params: array of const);
    property Items[Index: Integer]: IObserver read GetItem; default;
  end;

  TTaxiStop = class (TObject)
  private
    FObservers: TObserverList;
    FId: Integer;
    FName: String;
    FTaxis: TTaxiList;
    procedure SetName(Value: String);
  public
    constructor Create;
    destructor Destroy; override;
    property Id: Integer read FId write FId;
    property Name: String read FName write SetName;
    property Taxis: TTaxiList read FTaxis write FTaxis;
    property Observers: TObserverList read FObservers;
  end;

  TTaxiStopList = class (TObjectList)
  private
    FObservers: TObserverList;
    FStreet: TStreet;
    function GetItem(Index: Integer): TTaxiStop;
    function GetById(Id: Integer): TTaxiStop;
    function GetByName(Name: String): TTaxiStop;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    constructor Create(AOwnsObjects: Boolean);
    destructor Destroy; override;
    property Street: TStreet read FStreet write FStreet;
    property Items[Index: Integer]: TTaxiStop read GetItem; default;
    property ById[Id: Integer]: TTaxiStop read GetById;
    property ByName[Name: String]: TTaxiStop read GetByName;
    property Observers: TObserverList read FObservers;
  end;

  TStreet = class (TObject)
  private
    FObservers: TObserverList;
    FId: Integer;
    FName: String;
    FStart: String;
    FStop: String;
    FTaxiStops: TTaxiStopList;
    procedure SetName(Value: String);
    procedure SetStart(Value: String);
    procedure SetStop(Value: String);
  public
    constructor Create;
    destructor Destroy; override;
    property Id: Integer read FId write FId;
    property Name: String read FName write SetName;
    property Start: String read FStart write SetStart;
    property Stop: String read FStop write SetStop;
    property TaxiStops: TTaxiStopList read FTaxiStops;
    property Observers: TObserverList read FObservers;
  end;

  TStreetList = class (TObjectList)
  private
    FObservers: TObserverList;
    function GetItem(Index: Integer): TStreet;
    function GetById(Id: Integer): TStreet;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    constructor Create(AOwnsObjects: Boolean);
    destructor Destroy; override;
    property Items[Index: Integer]: TStreet read GetItem; default;
    property ById[Id: Integer]: TStreet read GetById;
    property Observers: TObserverList read FObservers;
  end;

  TTaxi = class (TObject)
  private
    FObservers: TObserverList;
    FId: Integer;
    FName: String;
    FNumber: String;
    FCallSign: String;
    procedure SetName(Value: String);
    procedure SetNumber(Value: String);
    procedure SetCallSign(Value: String);
  public
    constructor Create;
    destructor Destroy; override;
    property Id: Integer read FId write FId;
    property Name: String read FName write SetName;
    property Number: String read FNumber write SetNumber;
    property CallSign: String read FCallSign write SetCallSign;
    property Observers: TObserverList read FObservers;
  end;

  TTaxiList = class (TObjectList)
  private
    FObservers: TObserverList;
    FTaxiStop: TTaxiStop;
    function GetItem(Index: Integer): TTaxi;
    function GetByCallSign(CallSign: String): TTaxi;
    function GetById(Id: Integer): TTaxi;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    constructor Create(AOwnsObjects: Boolean);
    destructor Destroy; override;
    property TaxiStop: TTaxiStop read FTaxiStop write FTaxiStop;
    property Items[Index: Integer]: TTaxi read GetItem; default;
    property ByCallSign[CallSign: String]: TTaxi read GetByCallSign;
    property ById[Id: Integer]: TTaxi read GetById;
    property Observers: TObserverList read FObservers;
  end;

  TFare = class (TObject)
  private
    FObservers: TObserverList;
    FId: Integer;
    FStreet: String;
    FStreetId: Integer;
    FAddress1: String;
    FAddress2: String;
    FTaxiId: Integer;
    FReceived: TDateTime;
    FDispatched: TDateTime;
    FDelay: TDateTime;
    FDelayed: Boolean;
    FInformation: Boolean;
    FSent: Boolean;
    procedure SetStreet(Value: String);
    procedure SetStreetId(Value: Integer);
    procedure SetAddress1(Value: String);
    procedure SetAddress2(Value: String);
    procedure SetTaxiId(Value: Integer);
    procedure SetReceived(Value: TDateTime);
    procedure SetDispatched(Value: TDateTime);
    procedure SetDelay(Value: TDateTime);
    procedure SetDelayed(Value: Boolean);
    procedure SetInformation(Value: Boolean);
    procedure SetSent(Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    property Id: Integer read FId write FId;
    property Street: String read FStreet write SetStreet;
    property StreetId: Integer read FStreetId write SetStreetId;
    property Address1: String read FAddress1 write SetAddress1;
    property Address2: String read FAddress2 write SetAddress2;
    property TaxiId: Integer read FTaxiId write SetTaxiId;
    property Received: TDateTime read FReceived write SetReceived;
    property Dispatched: TDateTime read FDispatched write SetDispatched;
    property Delay: TDateTime read FDelay write SetDelay;
    property Delayed: Boolean read FDelayed write SetDelayed;
    property Information: Boolean read FInformation write SetInformation;
    property Sent: Boolean read FSent write SetSent;
    property Observers: TObserverList read FObservers;
  end;

  TFareList = class (TObjectList)
  private
    FObservers: TObserverList;
    function GetItem(Index: Integer): TFare;
    function GetById(Id: Integer): TFare;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    constructor Create(AOwnsObjects: Boolean);
    destructor Destroy; override;
    property Items[Index: Integer]: TFare read GetItem; default;
    property ById[Id: Integer]: TFare read GetById;
    property Observers: TObserverList read FObservers;
  end;

  TClient = class (TObject)
  private
    FObservers: TObserverList;
    FId: Integer;
    FName: String;
    FStreet: String;
    FAddress1: String;
    FAddress2: String;
    FTelephone: String;
    procedure SetId(Value: Integer);
    procedure SetName(Value: String);
    procedure SetStreet(Value: String);
    procedure SetAddress1(Value: String);
    procedure SetAddress2(Value: String);
    procedure SetTelephone(Value: String);
  public
    constructor Create;
    destructor Destroy; override;
    property Id: Integer read FId write SetId;
    property Name: String read FName write SetName;
    property Street: String read FStreet write SetStreet;
    property Address1: String read FAddress1 write SetAddress1;
    property Address2: String read FAddress2 write SetAddress2;
    property Telephone: String read FTelephone write SetTelephone;
    property Observers: TObserverList read FObservers;
  end;

  TClientList = class (TObjectList)
  private
    FObservers: TObserverList;
    function GetItem(Index: Integer): TClient;
    function GetById(Id: Integer): TClient;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    constructor Create(AOwnsObjects: Boolean);
    destructor Destroy; override;
    property Items[Index: Integer]: TClient read GetItem; default;
    property ById[Id: Integer]: TClient read GetById;
    property Observers: TObserverList read FObservers;
  end;

  TDatabase = class (TObject)
  private
    FStreets: TStreetList;
    FTaxiStops: TTaxiStopList;
    FTaxis: TTaxiList;
    FFares: TFareList;
    FClients: TClientList;
    class procedure Initialize;
    class procedure Shutdown;
  public
    class function Instance: TDatabase;
    constructor Create;
    destructor Destroy; override;
    property Streets: TStreetList read FStreets;
    property TaxiStops: TTaxiStopList read FTaxiStops;
    property Taxis: TTaxiList read FTaxis;
    property Fares: TFareList read FFares;
    property Clients: TClientList read FClients;
  end;

implementation

{ TObserverList }

{ Private declarations }

function TObserverList.GetItem(Index: Integer): IObserver;
begin
  Result := Get(Index) as IObserver;
end;

{ Public declarations }

procedure TObserverList.Register(Observer: IObserver);
begin
  Assert(IndexOf(Observer) = -1, 'Error: this observer has already been registered');
  Add(Observer);
end;

procedure TObserverList.Unregister(Observer: IObserver);
begin
  Assert(IndexOf(Observer) <> -1, 'Error: this observer has not been registered');
  Remove(Observer);
end;

procedure TObserverList.Notify(Sender: TObject; Subject: TObject; Params: array of const);
var
  I: Integer;
  PerformNotification: Boolean;
begin
  for I := 0 to Count - 1 do
    if Assigned(Items[I]) then
    begin
      if Supports(Items[I], IDisableable) then
        PerformNotification := (Items[I] as IDisableable).IsEnabled
      else
        PerformNotification := True;
      if PerformNotification then
        Items[I].Notify(Sender, Subject, Params);
    end;
end;

{ TTaxiStop }

{ Private declarations }

procedure TTaxiStop.SetName(Value: String);
begin
  if Value <> FName then
  begin
    FName := Value;
    Observers.Notify(Self, Self, ['Name', Name]);
  end;
end;

{ Public declarations }

constructor TTaxiStop.Create;
begin
  inherited Create;
  FObservers := TObserverList.Create;
  FTaxis := TTaxiList.Create(False);
  Taxis.TaxiStop := Self;
end;

destructor TTaxiStop.Destroy;
begin
  Observers.Clear;
  FreeAndNil(FTaxis);
  FreeAndNil(FObservers);
  inherited Destroy;
end;

{ TTaxiStopList }

{ Private declarations }

function TTaxiStopList.GetItem(Index: Integer): TTaxiStop;
begin
  Result := TObject(Get(Index)) as TTaxiStop;
end;

function TTaxiStopList.GetById(Id: Integer): TTaxiStop;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Id = Items[I].Id then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TTaxiStopList.GetByName(Name: String): TTaxiStop;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if AnsiSameText(Name, Items[I].Name) then
    begin
      Result := Items[I];
      Break;
    end;
end;

{ Protected declarations }

procedure TTaxiStopList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  Observers.Notify(Self, Ptr, [Integer(Action)]);
  inherited Notify(Ptr, Action);
end;

{ Public declarations }

constructor TTaxiStopList.Create(AOwnsObjects: Boolean);
begin
  inherited Create(AOwnsObjects);
  FObservers := TObserverList.Create;
end;

destructor TTaxiStopList.Destroy;
begin
  Observers.Clear;
  Clear;
  FreeAndNil(FObservers);
  inherited Destroy;
end;

{ TStreet }

{ Private declarations }

procedure TStreet.SetName(Value: String);
begin
  if FName <> Value then
  begin
    FName := Value;
    Observers.Notify(Self, Self, ['Name', Name]);
  end;
end;

procedure TStreet.SetStart(Value: String);
begin
  if FStart <> Value then
  begin
    FStart := Value;
    Observers.Notify(Self, Self, ['Start', Start]);
  end;
end;

procedure TStreet.SetStop(Value: String);
begin
  if FStop <> Value then
  begin
    FStop := Value;
    Observers.Notify(Self, Self, ['Stop', Stop]);
  end;
end;

{ Public declarations }

constructor TStreet.Create;
begin
  inherited Create;
  FTaxiStops := TTaxiStopList.Create(False);
  TaxiStops.Street := Self; 
  FObservers := TObserverList.Create;
end;

destructor TStreet.Destroy;
begin
  FreeAndNil(FTaxiStops);
  FreeAndNil(FObservers);
  inherited Destroy;
end;

{ TStreetList }

{ Private declarations }

function TStreetList.GetItem(Index: Integer): TStreet;
begin
  Result := TObject(Get(Index)) as TStreet;
end;

function TStreetList.GetById(Id: Integer): TStreet;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].Id = Id then
    begin
      Result := Items[I];
      Break;
    end;
end;

{ Protected declarations }

procedure TStreetList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  Observers.Notify(Self, Ptr, [Integer(Action)]);
  inherited Notify(Ptr, Action);
end;

{ Public declarations }

constructor TStreetList.Create(AOwnsObjects: Boolean);
begin
  inherited Create(AOwnsObjects);
  FObservers := TObserverList.Create;
end;

destructor TStreetList.Destroy;
begin
  Observers.Clear;
  Clear;
  FreeAndNil(FObservers);
  inherited Destroy;
end;

{ TTaxi }

{ Private declarations }

procedure TTaxi.SetName(Value: String);
begin
  if FName <> Value then
  begin
    FName := Value;
    Observers.Notify(Self, Self, ['Name', Name]);
  end;
end;

procedure TTaxi.SetNumber(Value: String);
begin
  if FNumber <> Value then
  begin
    FNumber := Value;
    Observers.Notify(Self, Self, ['Number', Number]);
  end;
end;

procedure TTaxi.SetCallSign(Value: String);
begin
  if FCallSign <> Value then
  begin
    FCallSign := Value;
    Observers.Notify(Self, Self, ['CallSign', CallSign]);
  end;
end;

{ Public declarations }

constructor TTaxi.Create;
begin
  inherited Create;
  FObservers := TObserverList.Create;
end;

destructor TTaxi.Destroy;
begin
  FreeAndNil(FObservers);
  inherited Destroy;
end;

{ TTaxiList }

{ Private declarations }

function TTaxiList.GetItem(Index: Integer): TTaxi;
begin
  Result := TObject(Get(Index)) as TTaxi;
end;

function TTaxiList.GetByCallSign(CallSign: String): TTaxi;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].CallSign = CallSign then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TTaxiList.GetById(Id: Integer): TTaxi;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].Id = Id then
    begin
      Result := Items[I];
      Break;
    end;
end;

{ Protected declarations }

procedure TTaxiList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  Observers.Notify(Self, Ptr, [Integer(Action)]);
  inherited Notify(Ptr, Action);
end;

{ Public declarations }

constructor TTaxiList.Create(AOwnsObjects: Boolean);
begin
  inherited Create(AOwnsObjects);
  FObservers := TObserverList.Create;
end;

destructor TTaxiList.Destroy;
begin
  Observers.Clear;
  Clear;
  FreeAndNil(FObservers);
  inherited Destroy;
end;

{ TFare }

{ Private declarations }

procedure TFare.SetStreet(Value: String);
begin
  if FStreet <> Value then
  begin
    FStreet := Value;
    Observers.Notify(Self, Self, ['Street', Street]);
  end;
end;

procedure TFare.SetStreetId(Value: Integer);
begin
  if FStreetId <> Value then
  begin
    FStreetId := Value;
    Observers.Notify(Self, Self, ['StreetId', StreetId]);
  end;
end;

procedure TFare.SetAddress1(Value: String);
begin
  if FAddress1 <> Value then
  begin
    FAddress1 := Value;
    Observers.Notify(Self, Self, ['Address1', Address1]);
  end;
end;

procedure TFare.SetAddress2(Value: String);
begin
  if FAddress2 <> Value then
  begin
    FAddress2 := Value;
    Observers.Notify(Self, Self, ['Address2', Address2]);
  end;
end;

procedure TFare.SetTaxiId(Value: Integer);
begin
  if FTaxiId <> Value then
  begin
    FTaxiId := Value;
    Observers.Notify(Self, Self, ['TaxiId', TaxiId]);
  end;
end;

procedure TFare.SetReceived(Value: TDateTime);
begin
  if FReceived <> Value then
  begin
    FReceived := Value;
    Observers.Notify(Self, Self, ['Received', Received]);
  end;
end;

procedure TFare.SetDispatched(Value: TDateTime);
begin
  if FDispatched <> Value then
  begin
    FDispatched := Value;
    Observers.Notify(Self, Self, ['Dispatched', Dispatched]);
  end;
end;

procedure TFare.SetDelay(Value: TDateTime);
begin
  if FDelay <> Value then
  begin
    FDelay := Value;
    Observers.Notify(Self, Self, ['Delay', Delay]);
  end;
end;

procedure TFare.SetDelayed(Value: Boolean);
begin
  if FDelayed <> Value then
  begin
    FDelayed := Value;
    Observers.Notify(Self, Self, ['Delayed', Delayed]);
  end;
end;

procedure TFare.SetInformation(Value: Boolean);
begin
  if FInformation <> Value then
  begin
    FInformation := Value;
    Observers.Notify(Self, Self, ['Information', Information]);
  end;
end;

procedure TFare.SetSent(Value: Boolean);
begin
  if FSent <> Value then
  begin
    FSent := Value;
    Observers.Notify(Self, Self, ['Sent', Sent]);
  end;
end;

{ Public declarations }

constructor TFare.Create;
begin
  inherited Create;
  FObservers := TObserverList.Create;
end;

destructor TFare.Destroy;
begin
  FreeAndNil(FObservers);
  inherited Destroy;
end;

{ TFareList }

{ Private declarations }

function TFareList.GetItem(Index: Integer): TFare;
begin
  Result := TObject(Get(Index)) as TFare;
end;

function TFareList.GetById(Id: Integer): TFare;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].Id = Id then
    begin
      Result := Items[I];
      Break;
    end;
end;

{ Protected declarations }

procedure TFareList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  Observers.Notify(Self, Ptr, [Integer(Action)]);
  inherited Notify(Ptr, Action);
end;

{ Public declarations }

constructor TFareList.Create(AOwnsObjects: Boolean);
begin
  inherited Create(AOwnsObjects);
  FObservers := TObserverList.Create;
end;

destructor TFareList.Destroy;
begin
  Observers.Clear;
  Clear;
  FreeAndNil(FObservers);
  inherited Destroy;
end;

{ TClient }

{ Private declarations }

procedure TClient.SetId(Value: Integer);
begin
  if Value <> FId then
  begin
    FId := Value;
    Observers.Notify(Self, Self, ['Id', Id]);
  end;
end;

procedure TClient.SetName(Value: String);
begin
  if Value <> FName then
  begin
    FName := Value;
    Observers.Notify(Self, Self, ['Name', Name]);
  end;
end;

procedure TClient.SetStreet(Value: String);
begin
  if Value <> FStreet then
  begin
    FStreet := Value;
    Observers.Notify(Self, Self, ['Street', Street]);
  end;
end;

procedure TClient.SetAddress1(Value: String);
begin
  if Value <> FAddress1 then
  begin
    FAddress1 := Value;
    Observers.Notify(Self, Self, ['Address1', Address1]);
  end;
end;

procedure TClient.SetAddress2(Value: String);
begin
  if Value <> FAddress2 then
  begin
    FAddress2 := Value;
    Observers.Notify(Self, Self, ['Address2', Address2]);
  end;
end;

procedure TClient.SetTelephone(Value: String);
begin
  if Value <> FTelephone then
  begin
    FTelephone := Value;
    Observers.Notify(Self, Self, ['Telephone', Telephone]);
  end;
end;

{ Public declarations }

constructor TClient.Create;
begin
  inherited Create;
  FObservers := TObserverList.Create;
end;

destructor TClient.Destroy;
begin
  FreeAndNil(FObservers);
  inherited Destroy;
end;

{ TClientList }

{ Private declarations }

function TClientList.GetItem(Index: Integer): TClient;
begin
  Result := TObject(Get(Index)) as TClient;
end;

function TClientList.GetById(Id: Integer): TClient;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].Id = Id then
    begin
      Result := Items[I];
      Break;
    end;
end;

{ Protected declarations }

procedure TClientList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  Observers.Notify(Self, Ptr, [Integer(Action)]);
  inherited Notify(Ptr, Action);
end;

{ Public declarations }

constructor TClientList.Create(AOwnsObjects: Boolean);
begin
  inherited Create(AOwnsObjects);
  FObservers := TObserverList.Create;
end;

destructor TClientList.Destroy;
begin
  Observers.Clear;
  Clear;
  FreeAndNil(FObservers);
  inherited Destroy;
end;

{ TDatabase }

var
  _Instance: TDatabase = nil;

{ Private declarations }

class procedure TDatabase.Initialize;
begin
  _Instance := TDatabase.Create;
end;

class procedure TDatabase.Shutdown;
begin
  FreeAndNil(_Instance);
end;

{ Public declarations }

class function TDatabase.Instance: TDatabase;
begin
  Result := _Instance;
end;

constructor TDatabase.Create;
begin
  inherited Create;
  FStreets := TStreetList.Create(True);
  FTaxiStops := TTaxiStopList.Create(True);
  FTaxis := TTaxiList.Create(True);
  FFares := TFareList.Create(True);
  FClients := TClientList.Create(True);
end;

destructor TDatabase.Destroy;
begin
  FreeAndNil(FClients);
  FreeAndNil(FFares);
  FreeAndNil(FTaxis);
  FreeAndNil(FTaxiStops);
  FreeAndNil(FStreets);
  inherited Destroy;
end;

initialization
  TDatabase.Initialize;

finalization
  TDatabase.Shutdown;  

end.

