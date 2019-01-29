Uses System, CRT;
const
  tricks: integer = 15;
  dump: integer = integer.MaxValue;
  guimax: integer = 100;
  towns: integer = 154;
  scale: real = 0.002;
  kA: real = 1.15;//Коэффициент длины маршрута автомобиля
  kR: real = 0.85;//Коэффициент длины маршрута поезда
  kF: real = 1;//Коэффициент длины маршрута самолёта
  kPR: real = 4.25;//Коэффициент цены билета на поезд
  kPF: real = 9.65;//Коэффициент цены билета на самолёт

var
  main: record
    const version: string = '1.1';
    const fullvers: string = '11VA';
    const autor: string = 'Alexandr Kotov vk.com/id219453333';
    sizex: integer = 110;
    sizey: integer = 30;
    const fore: consolecolor = consolecolor.black;
    const back: consolecolor = consolecolor.white;
  end;
  
  menu: record
    status: boolean;
    input: string;
    output: integer;
  end;
  
  guifile: textfile;
  guiinput: string;
  guiid, guiid2: integer;
  inter: array[1..guimax] of record
    face: array of string;
  end;
  
  savefile: textfile;
  saveinput: string;
  save: record
    version: string;
    status: boolean;
    autosave: boolean;
  end;
  
  player: record
    nickname: string;
    position: integer;
    money: uint64;
    tricklvl: integer;
    trickindex: real;
  end;
  
  bike: record
    status: boolean;
    name: string;
    speed: integer;
    price: integer;
    trickmax: integer;
  end;
  
  date: record
    day: integer;
    month: integer;
    monthstr: string;
    year: integer;
    time: integer;
    timestr: string;
    output: string;
    hour: integer;
    hourstr: string;
    minute: integer;
    minutestr: string;
    dlast, mlast: integer;
  end;
  
  game: record
    status: boolean;
    input: string;
    output: integer;
  end;
  
  shop: record
    verify: boolean;
    status: boolean;
    input: string;
    output: integer;
  end;
  
  shopbuy: record
    restart: boolean;
    status: boolean;
    input: string;
    output: integer;
    bike: record
      name: string;
      speed: integer;
      maxtrick: integer;
      price: longword;
    end;
  end;
  
  shoporder: record
    prog: integer;
    status: boolean;
    input: string;
    output: integer;
    bike: record
      name: string;
      speed: integer;
      maxtrick: integer;
      price: longword;
    end;
  end;
  
  shoporder1: record
    status: boolean;
    input: string;
    output: integer;
    verify: boolean;
  end;
  
  shoporder2: record
    status: boolean;
    input: string;
    output: integer;
    verify: boolean;
    sort: integer;
  end;
  
  shopsale: record
    status: boolean;
    input: string;
    output: integer;    
  end;
  
  mapfile: textfile;
  mapid: integer;
  mapinput: string;
  map: array[1..towns] of record
    ///Название города
    name: string;
    ///Тип города
    sort: integer;
    ///Округ/Район
    sortstr: string;
    ///Округ/Район
    area: string;
    ///Позиция по x
    posx: real;
    ///Позиция по y
    posy: real;
    ///Автомобильные дороги
    Aroad: array[1..towns] of boolean;//Автодороги
    ///Железные дороги
    Rroad: array[1..towns] of boolean;//Ж/Д
    ///Аэромаршруты
    Froad: array[1..towns] of boolean;//АЭРО
    shop_op_h: integer;
    shop_op_m: integer;
    shop_cl_h: integer;
    shop_cl_m: integer;
  end;
  
  adv: record
    status: boolean;
    input: string;
    output: integer;
    verifyA: boolean;
    verifyF: boolean;
    verifyR: boolean;
  end;
  
  adva: record
    status: boolean;
    input: string;
    output: integer;
    arr: array[1..towns] of integer;
    maxt: integer;
    error: integer;
    dst: integer;
    curdst: integer;
  end;
  
  advr: record
    status: boolean;
    input: string;
    output: integer;
    arr: array[1..towns] of integer;
    price: array[1..towns] of integer;
    maxt: integer;
    error: integer;
    dst: integer;
    curdst: integer;
    speed: integer;
  end;  
  
  advf: record
    status: boolean;
    input: string;
    output: integer;
    arr: array[1..towns] of integer;
    price: array[1..towns] of integer;
    maxt: integer;
    error: integer;
    dst: integer;
    curdst: integer;
    speed: integer;
  end;
  
  trick: array[1..tricks] of record
    name: string;
    price: integer;
    rprice: integer;
    sprice: integer;
  end;
  
  truck: record
    price: integer;
    max: integer;
    error: integer;
    status: boolean;
    input: string;
    output: integer;
    count: integer;
    prog: integer;
    arr: array[1..towns] of integer;
    town: integer;
    select: boolean;
    maxt: integer;
    sizer: integer;
  end;
  
  newgamech: record
    status: boolean;
    input: string;
    output: integer;
  end;
  
  newgame: record
    status: boolean;
    input: string;
    output: integer;
  end;
  ///Ник
  newgame1: record//Ник
    verify: boolean;
    status: boolean;
    input: string;
    output: integer;
  end;
  
  ///Дата
  newgame2: record//Дата
    verify: boolean;
    status: boolean;
    input: string;
    output: integer;
  end;
  
  ///Точка 
  newgame3: record//Точка
    verify: boolean;
    status: boolean;
    input: string;
    output: integer;
    arr: array[1..towns] of integer;
    max: integer;
  end;
  
  school: record
    prog: integer;
    status: boolean;
    input: string;
    output: integer;
  end;
  
  relax: record
    prog: integer;
    status: boolean;
    input: string;
    output: integer;
  end;
  
  energy: record
    text: boolean;
    value: integer;
    const max: integer = 10;
    const min: integer = 0;
  end;
  
  setup: record
    verify: boolean;
    status: boolean;
    input: string;
    output: integer;
  end;
  
  turnir: record
    stage: integer;
    input: string;
    output: integer;
    status: boolean;
    win: boolean;
    award: integer;
    place: integer;
  end;
  //Прочие

procedure spc;
begin
  write(' ');
end;

procedure spc(n: integer);
begin
  for var i:=1 to n do spc;
end;


procedure wnd(x, y, sx, sy: integer);
begin
  Console.BackgroundColor := consolecolor.Gray;
  gotoxy(x, y);spc(sx + 2);
  for var i := 1 to sy do
  begin
    gotoxy(x, y + i);spc;
    gotoxy(x + sx + 1, y + i);spc;
  end;
  gotoxy(x, y + sy);spc(sx + 2);
  Console.BackgroundColor := consolecolor.White;
end;

procedure wnd(x, y, sx, sy: integer; s: string);
begin
  Console.BackgroundColor := consolecolor.Gray;
  gotoxy(x, y);spc(sx + 2);
  for var i := 1 to sy do
  begin
    gotoxy(x, y + i);spc;
    gotoxy(x + sx + 1, y + i);spc;
  end;
  gotoxy(x, y + sy);spc(sx + 2);
  gotoxy(x + 1, y);write(s);
  Console.BackgroundColor := consolecolor.White;
end;

procedure resize;
begin
  console.SetWindowSize(main.sizex, main.sizey);
  console.SetBufferSize(main.sizex, main.sizey);
  console.BackgroundColor := main.back;
  console.ForegroundColor := main.fore;
end;


procedure saver();
begin
  assign(savefile, 'save.dat');
  rewrite(savefile);
  //Перезапись сохранения
  writeln(savefile, 'version=', main.fullvers);
  writeln(savefile, 'autosave=', save.autosave);
  writeln(savefile, 'nickname=', player.nickname);
  writeln(savefile, 'tricklvl=', player.tricklvl);
  writeln(savefile, 'trickindex=', player.trickindex);
  writeln(savefile, 'tricktown=', truck.town);
  writeln(savefile, 'energy=', energy.value);
  writeln(savefile, 'energytext=', energy.text);
  writeln(savefile, 'town=', player.position);
  writeln(savefile, 'sizex=', main.sizex);
  writeln(savefile, 'sizey=', main.sizey);
  writeln(savefile, 'money=', player.money);
  writeln(savefile, 'dateminute=', date.minute);
  writeln(savefile, 'datehour=', date.hour);
  writeln(savefile, 'datetime=', date.time);
  writeln(savefile, 'dateday=', date.day);
  writeln(savefile, 'datemonth=', date.month);
  writeln(savefile, 'dateyear=', date.year);
  writeln(savefile, 'datedl=', date.dlast);
  writeln(savefile, 'dateml=', date.mlast);
  writeln(savefile, 'bikestatus=', bike.status);
  if bike.status = true then
  begin
    writeln(savefile, 'bikename=', bike.name);
    writeln(savefile, 'bikespeed=', bike.speed);
    writeln(savefile, 'bikeprice=', bike.price);
    writeln(savefile, 'bikemaxtrick=', bike.trickmax);
  end;
  close(savefile);
end;

procedure loader();
begin
  if fileexists('save.dat') = true then
  begin
    save.status := true;
    assign(savefile, 'save.dat');
    reset(savefile);
    while eof(savefile) <> true do
    begin
      readln(savefile, saveinput);
      //Чтение сохранения
      if copy(saveinput, 1, 9) = 'autosave=' then
      begin
        save.autosave := boolean.Parse(copy(saveinput, 10, 255));
      end;
      if copy(saveinput, 1, 6) = 'sizex=' then
      begin
        main.sizex := strtoint(copy(saveinput, 7, 255));
      end;
      if copy(saveinput, 1, 6) = 'sizey=' then
      begin
        main.sizey := strtoint(copy(saveinput, 7, 255));
      end;
      if copy(saveinput, 1, 9) = 'nickname=' then
      begin
        player.nickname := copy(saveinput, 10, 255);
      end;
      if copy(saveinput, 1, 5) = 'town=' then
      begin
        player.position := strtoint(copy(saveinput, 6, 255));
      end;
      if copy(saveinput, 1, 8) = 'dateday=' then
      begin
        date.day := strtoint(copy(saveinput, 9, 255));
      end;
      if copy(saveinput, 1, 10) = 'datemonth=' then
      begin
        date.month := strtoint(copy(saveinput, 11, 255));
      end;
      if copy(saveinput, 1, 9) = 'dateyear=' then
      begin
        date.year := strtoint(copy(saveinput, 10, 255));
      end;
      if copy(saveinput, 1, 9) = 'datetime=' then
      begin
        date.time := strtoint(copy(saveinput, 10, 255));
      end;
      if copy(saveinput, 1, 9) = 'datehour=' then
      begin
        date.hour := strtoint(copy(saveinput, 10, 255));
      end;
      if copy(saveinput, 1, 11) = 'dateminute=' then
      begin
        date.minute := strtoint(copy(saveinput, 12, 255));
      end;
      if copy(saveinput, 1, 6) = 'money=' then
      begin
        player.money := uint64.Parse(copy(saveinput, 7, 255));
      end;
      if copy(saveinput, 1, 11) = 'bikestatus=' then
      begin
        bike.status := boolean.Parse(copy(saveinput, 12, 255));
      end;
      if copy(saveinput, 1, 11) = 'energytext=' then
      begin
        energy.text := boolean.Parse(copy(saveinput, 12, 255));
      end;
      if copy(saveinput, 1, 7) = 'energy=' then
      begin
        energy.value := strtoint(copy(saveinput, 8, 255));
      end;
      if copy(saveinput, 1, 9) = 'bikename=' then
      begin
        bike.name := copy(saveinput, 10, 255);
      end;
      if copy(saveinput, 1, 10) = 'bikespeed=' then
      begin
        bike.speed := strtoint(copy(saveinput, 11, 255));
      end;
      if copy(saveinput, 1, 10) = 'bikeprice=' then
      begin
        bike.price := strtoint(copy(saveinput, 11, 255));
      end;
      if copy(saveinput, 1, 13) = 'bikemaxtrick=' then
      begin
        bike.trickmax := strtoint(copy(saveinput, 14, 255));
      end;
      if copy(saveinput, 1, 9) = 'tricklvl=' then
      begin
        player.tricklvl := strtoint(copy(saveinput, 10, 255));
      end;
      if copy(saveinput, 1, 11) = 'trickindex=' then
      begin
        player.trickindex := strtofloat(copy(saveinput, 12, 255));
      end;
      if copy(saveinput, 1, 11) = 'trickcount=' then
      begin
        truck.count := strtoint(copy(saveinput, 12, 255));
      end;
      if copy(saveinput, 1, 10) = 'tricktown=' then
      begin
        truck.town := strtoint(copy(saveinput, 11, 255));
      end;
      if copy(saveinput, 1, 7) = 'datedl=' then
      begin
        date.dlast := strtoint(copy(saveinput, 8, 255));
      end;
      if copy(saveinput, 1, 7) = 'dateml=' then
      begin
        date.mlast := strtoint(copy(saveinput, 8, 255));
      end;
      if copy(saveinput, 1, 8) = 'version=' then
      begin
        save.version := copy(saveinput, 9, 255);
        if save.version <> main.fullvers then begin
          //TODO Отладочка
          if save.version = '10V' then
          begin
            energy.text := false;
            energy.value := truck.count * 2;
            if player.tricklvl < 3 then player.tricklvl := 3;
            player.trickindex := 1 + (player.tricklvl / 100);
            truck.maxt := 0;
            for var i := 1 to towns do
            begin
              if (map[i].sort > 2) and (map[i].sort < 7) then
              begin
                inc(truck.maxt);
                truck.arr[truck.maxt] := i;
              end;
            end;
            main.sizex := 110;
            main.sizey := 30;
            truck.town := truck.arr[pabcsystem.random(truck.maxt) + 1];
            truck.select := false;
          end;
        end;
      end;
    end;
    close(savefile);
  end
  else
  begin
    save.status := false;
  end;
end;

function dgt(n: uint64): string;
begin
  var s, k: string;
  k := n.ToString;
  for var i := 1 to k.length do
  begin
    s := s + k[i];
    if ((i - (k.Length mod 3)) mod 3 = 0) and (i < k.Length) then s := s + ' ';
  end;
  Result := s;
end;

procedure upface;
begin
  Console.BackgroundColor := ConsoleColor.Cyan;
  spc;
  write(player.nickname);
  spc;
  Console.BackgroundColor := ConsoleColor.Green;
  spc;
  write(dgt(player.money));
  spc;
  case player.money mod 100 of
    1, 21, 31, 41, 51, 61, 71, 81, 91: write(inter[2].face[16]);
    2..4, 22..24, 32..34, 42..44, 52..54, 62..64, 72..74, 82..84, 92..94: write(inter[2].face[17]);
    0, 5..20, 25..30, 35..40, 45..50, 55..60, 65..70, 75..80, 85..90, 95..99: write(inter[2].face[18]);
  end;
  spc;
  console.BackgroundColor := consolecolor.Gray;
  spc(3);
  if energy.text = true then
  begin
    Console.BackgroundColor := Consolecolor.Red;
    Console.ForegroundColor := consolecolor.Yellow;
    spc;write(energy.value, '/', energy.max);spc;
    Console.ForegroundColor := main.fore;
  end
  else
  begin
    Console.BackgroundColor := Consolecolor.Red;
    if energy.min <> energy.value then for var i := energy.min + 1 to energy.value do spc; 
    Console.BackgroundColor := Consolecolor.DarkRed;
    if energy.max > energy.value then for var i := energy.value + 1 to energy.max do spc; 
  end;
  console.BackgroundColor := consolecolor.Gray;
  while wherex < main.sizex do spc;
  if date.minute div 60 > 0 then
  begin
    inc(date.hour, date.minute div 60);
    date.minute := date.minute mod 60;
  end;
  if date.hour div 24 > 0 then
  begin
    inc(date.day, date.hour div 24);
    date.hour := date.hour mod 24;
    truck.count := 5;
  end;
  if date.time mod 4 = 0 then
  begin
    date.timestr := inter[2].face[0];
    inc(date.day, date.time div 4);
    date.time := 0;
  end;
  if date.time mod 4 = 1 then
  begin
    date.timestr := inter[2].face[1];
    inc(date.day, date.time div 4);
    date.time := 1;
  end;
  if date.time mod 4 = 2 then
  begin
    date.timestr := inter[2].face[2];
    inc(date.day, date.time div 4);
    date.time := 2;
  end;
  if date.time mod 4 = 3 then
  begin
    date.timestr := inter[2].face[3];
    inc(date.day, date.time div 4);
    date.time := 3;
  end;
  if (date.day mod 7 = 0) and ((date.day <> date.dlast) or (date.month <> date.mlast)) and ((date.month > 5) and (date.month < 9)) then
  begin
    date.dlast := date.day;
    date.mlast := date.month;
    truck.select := true;
  end;
  if (date.month < 6) or (date.month > 8) then truck.town := 0;
  while not (((date.day <= 28) and (date.month = 2) and (date.year mod 4 <> 0)) or ((date.day <= 29) and (date.month = 2) and (date.year mod 4 = 0)) or ((date.day <= 30) and ((date.month = 4) or (date.month = 6) or (date.month = 9) or (date.month = 11))) or ((date.day <= 31) and ((date.month = 1) or (date.month = 3) or (date.month = 5) or (date.month = 7) or (date.month = 8) or (date.month = 10) or (date.month = 12)))) do
  begin
    if (date.day > 28) and (date.month = 2) and (date.year mod 4 <> 0) then
    begin
      date.day := date.day - 28;
      inc(date.month);
    end;
    if (date.day > 29) and (date.month = 2) and (date.year mod 4 = 0) then
    begin
      date.day := date.day - 29;
      inc(date.month);
    end;
    if (date.day > 30) and ((date.month = 4) or (date.month = 6) or (date.month = 9) or (date.month = 11)) then
    begin
      date.day := date.day - 30;
      inc(date.month);
    end;
    if (date.day > 31) and ((date.month = 1) or (date.month = 3) or (date.month = 5) or (date.month = 7) or (date.month = 8) or (date.month = 10)) then
    begin
      date.day := date.day - 31;
      inc(date.month);
    end;
    if (date.day > 31) and (date.month = 12) then
    begin
      date.day := date.day - 31;
      date.month := 1;
      inc(date.year);
    end;
    if (date.month > 12) then
    begin
      date.month := date.month - 12;
    end;
  end;
  if truck.select = true then
  begin
    truck.maxt := 0;
    for var i := 1 to towns do
    begin
      if (map[i].sort > 2) and (map[i].sort < 7) then
      begin
        inc(truck.maxt);
        truck.arr[truck.maxt] := i;
      end;
    end;
    truck.town := truck.arr[pabcsystem.random(truck.maxt) + 1];
    truck.select := false;
  end;
  case date.month of
    1: date.monthstr := inter[2].face[4];
    2: date.monthstr := inter[2].face[5];
    3: date.monthstr := inter[2].face[6];
    4: date.monthstr := inter[2].face[7];
    5: date.monthstr := inter[2].face[8];
    6: date.monthstr := inter[2].face[9];
    7: date.monthstr := inter[2].face[10];
    8: date.monthstr := inter[2].face[11];
    9: date.monthstr := inter[2].face[12];
    10: date.monthstr := inter[2].face[13];
    11: date.monthstr := inter[2].face[14];
    12: date.monthstr := inter[2].face[15];
  end;
  if date.hour >= 10 then date.hourstr := inttostr(date.hour) else date.hourstr := '0' + inttostr(date.hour);
  if date.minute >= 10 then date.minutestr := inttostr(date.minute) else date.minutestr := '0' + inttostr(date.minute);
  date.output := date.hourstr + ':' + date.minutestr + ' ' + date.day + ' ' + date.monthstr + ' ' + date.year;
  gotoxy(main.sizex - length(date.output) - 1, 1);write(date.output);
  gotoxy(main.sizex - length(date.output) - length(map[player.position].sortstr) - length(map[player.position].name) - 5, 1);
  write(map[player.position].sortstr, ' ', map[player.position].name, ',');
  Console.BackgroundColor := main.back;
end;

begin
  Console.Title := 'Biker';
  if FileExists('interface.dat') = true then
  begin
    assign(guifile, 'interface.dat');
    reset(guifile);
    while eof(guifile) <> true do
    begin
      readln(guifile, guiinput);
      if copy(guiinput, 1, 6) = 'block=' then guiid := integer.Parse(copy(guiinput, 7, 255));
      if copy(guiinput, 1, 6) = 'lines=' then
      begin
        setlength(inter[guiid].face, integer.Parse(copy(guiinput, 7, 255)));
        guiid2 := 0;
      end;
      if (copy(guiinput, 1, 6) = '&line=') and (guiid2 < inter[guiid].face.Length) then
      begin
        inter[guiid].face[guiid2] := copy(guiinput, 7, 255);
        inc(guiid2);
      end;
    end;
    close(guifile);
  end
  else exit;
  for var i := 0 to inter[12].face.Length do
  begin
    if (i > 0) then
    begin
      trick[i].name := inter[12].face[i - 1];
      trick[i].price := strtoint(inter[13].face[i - 1]);
      trick[i].rprice := strtoint(inter[14].face[i - 1]);
      trick[i].sprice := strtoint(inter[22].face[i - 1]);
    end;
  end;
  if FileExists('map.dat') = true then
  begin
    assign(mapfile, 'map.dat');
    reset(mapfile);
    while eof(mapfile) <> true do
    begin
      readln(mapfile, mapinput);
      if copy(mapinput, 1, 6) = '%town=' then mapid := strtoint(copy(mapinput, 7, 255));
      if copy(mapinput, 1, 6) = '&name=' then map[mapid].name := copy(mapinput, 7, 255);
      if copy(mapinput, 1, 6) = '&type=' then map[mapid].sort := strtoint(copy(mapinput, 7, 255));
      if copy(mapinput, 1, 6) = '&area=' then map[mapid].area := copy(mapinput, 7, 255);
      if copy(mapinput, 1, 6) = '&posx=' then
      begin
        map[mapid].posx := strtofloat(copy(mapinput, 7, 255)) * scale;
      end;
      if copy(mapinput, 1, 6) = '&posy=' then
      begin
        map[mapid].posy := strtofloat(copy(mapinput, 7, 255)) * scale;
      end;
      if copy(mapinput, 1, 7) = '&Aroad=' then map[mapid].Aroad[strtoint(copy(mapinput, 8, 255))] := true;
      if copy(mapinput, 1, 7) = '&Froad=' then map[mapid].Froad[strtoint(copy(mapinput, 8, 255))] := true;
      if copy(mapinput, 1, 7) = '&Rroad=' then map[mapid].Rroad[strtoint(copy(mapinput, 8, 255))] := true;
    end;
    close(mapfile);
    for var i := 1 to towns do
    begin
      case map[i].sort of
        1: map[i].sortstr := inter[8].face[0];
        2: map[i].sortstr := inter[8].face[1];
        3: map[i].sortstr := inter[8].face[2];
        4: map[i].sortstr := inter[8].face[3];
        5: map[i].sortstr := inter[8].face[4];
        6: map[i].sortstr := inter[8].face[5];
        7: map[i].sortstr := inter[8].face[6];
        8: map[i].sortstr := inter[8].face[7];
      end;
      
      case map[i].sort of
        2: 
          begin
            map[i].shop_op_h := 10;
            map[i].shop_op_m := 0;
            map[i].shop_cl_h := 18;
            map[i].shop_cl_m := 0;
          end;
        3: 
          begin
            map[i].shop_op_h := 9;
            map[i].shop_op_m := 30;
            map[i].shop_cl_h := 18;
            map[i].shop_cl_m := 30;
          end;
        4: 
          begin
            map[i].shop_op_h := 9;
            map[i].shop_op_m := 0;
            map[i].shop_cl_h := 19;
            map[i].shop_cl_m := 0;
          end;
        5: 
          begin
            map[i].shop_op_h := 9;
            map[i].shop_op_m := 0;
            map[i].shop_cl_h := 19;
            map[i].shop_cl_m := 30;
          end;
        6: 
          begin
            map[i].shop_op_h := 8;
            map[i].shop_op_m := 30;
            map[i].shop_cl_h := 21;
            map[i].shop_cl_m := 0;
          end;
        7, 8: 
          begin
            map[i].shop_op_h := 0;
            map[i].shop_op_m := 0;
            map[i].shop_cl_h := 0;
            map[i].shop_cl_m := 0;
          end;
      end;
    end;
  end
  else exit;
  loader;
  menu.status := true;
  while menu.status = true do
  begin
    loader;
    resize;
    Console.Clear;
    menu.output := dump;
    //Интерфейс
    gotoxy(2, 2);write('(1) ', inter[1].face[0]);
    gotoxy(2, 3);
    if save.status = false then
    begin
      console.ForegroundColor := consolecolor.Gray;
      write('(2) ', inter[1].face[1]);
      console.ForegroundColor := consolecolor.Black;
    end
    else
    begin
      write('(2) ', inter[1].face[1]);
    end;
    gotoxy(2, 4);write('(3) ', inter[1].face[3]);
    gotoxy(2, 5);write('(0) ', inter[1].face[2]);
    gotoxy(main.sizex - length(main.version) - 6, main.sizey - 3);
    write('Biker ', main.version);
    gotoxy(main.sizex - length(main.autor), main.sizey - 2);
    write(main.autor);
    //Ввод
    gotoxy(1, main.sizey - 1);write(' : ');
    readln(menu.input);
    //Проверка
    if menu.input = '0' then menu.output := 0;
    if menu.input = '1' then menu.output := 1;
    if (menu.input = '2') and (save.status = true) then menu.output := 2;
    if menu.input = '3' then menu.output := 3;
    //Действие
    if menu.output = 0 then menu.status := false;
    if menu.output = 1 then
    begin
      if save.status = true then newgamech.status := true else newgame.status := true;
      while newgamech.status = true do
      begin
        console.Clear;
        newgamech.output := dump;
        gotoxy(2, 2);write(inter[16].face[0], ' "', player.nickname, '"');
        gotoxy(2, 3);write(inter[16].face[1]);
        gotoxy(2, 4);write(inter[16].face[2], '?');
        gotoxy(3, 5);write('(1) ', inter[16].face[3]);
        gotoxy(3, 6);write('(0) ', inter[16].face[4]);
        gotoxy(1, main.sizey - 1);write(' : ');
        readln(newgamech.input);
        if newgamech.input = '0' then newgamech.output := 0;
        if newgamech.input = '1' then newgamech.output := 1;
        if newgamech.output = 0 then newgamech.status := false;
        if newgamech.output = 1 then
        begin
          erase(savefile);
          save.status := false;
          newgamech.status := false;
          newgame.status := true;
        end;
      end;
      while newgame.status = true do
      begin
        console.Clear;
        newgame.output := dump;
        //Интерфейс
        gotoxy(2, 2);
        if (newgame1.verify = true) and (newgame2.verify = true) and (newgame3.verify = true) then
          write('(1) ', inter[17].face[0])
        else
        begin
          Console.ForegroundColor := consolecolor.Gray;
          write('(1) ', inter[17].face[0]);
          Console.ForegroundColor := main.fore;
        end;
        gotoxy(2, 3);
        if (newgame1.verify = true) then
          write('(2) ', inter[17].face[1], ' (', player.nickname, ')')
        else
        begin
          Console.ForegroundColor := consolecolor.Red;
          write('(2) ', inter[17].face[1]);
          Console.ForegroundColor := main.fore;
        end;
        gotoxy(2, 4);
        if (newgame2.verify = true) then
        begin
          write('(3) ', inter[17].face[2], ' (');
          if date.day < 10 then write('0', date.day) else write(date.day);
          write('.');
          if date.month < 10 then write('0', date.month) else write(date.month);
          write('.', date.year);
          write(')');
        end
        else
        begin
          Console.ForegroundColor := consolecolor.Red;
          write('(3) ', inter[17].face[2]);
          Console.ForegroundColor := main.fore;
        end;
        gotoxy(2, 5);
        if (newgame3.verify = true) then
          write('(4) ', inter[17].face[3], ' (', map[player.position].sortstr, ' ', map[player.position].name, ')')
        else
        begin
          Console.ForegroundColor := consolecolor.Red;
          write('(4) ', inter[17].face[3]);
          Console.ForegroundColor := main.fore;
        end;
        gotoxy(2, 6);write('(0) ', inter[17].face[4]);
        //Ввод
        gotoxy(1, main.sizey - 1);write(' : ');
        readln(newgame.input);
        //Проверка
        if newgame.input = '0' then newgame.output := 0;
        if (newgame.input = '1') and (newgame1.verify = true) and (newgame2.verify = true) and (newgame3.verify = true) then newgame.output := 1;
        if newgame.input = '2' then newgame.output := 2;
        if newgame.input = '3' then newgame.output := 3;
        if newgame.input = '4' then newgame.output := 4;
        //Действие
        if newgame.output = 0 then newgame.status := false;
        if newgame.output = 1 then
        begin
          bike.name := inter[9].face[pabcsystem.random(inter[9].face.Length)];
          bike.price := 3000;
          bike.trickmax := 3;
          player.tricklvl := 1;
          bike.speed := 15;
          bike.status := true;
          date.minute := 0;
          newgame.status := false;
          save.status := true;
          save.autosave := true;
          saver;
          player.money := 5000;
          player.trickindex := 1;
          menu.output := 2;
          truck.count := 5;
          energy.value := energy.max;
          energy.text := false;
          truck.maxt := 0;
          for var i := 1 to towns do
          begin
            if (map[i].sort > 2) and (map[i].sort < 7) then
            begin
              inc(truck.maxt);
              truck.arr[truck.maxt] := i;
            end;
          end;
          truck.town := truck.arr[pabcsystem.random(truck.maxt) + 1];
          truck.select := false;
        end;
        if newgame.output = 2 then
        begin
          newgame1.status := true;
          while newgame1.status = true do
          begin
            Console.Clear;
            newgame1.output := dump;
            //Интерфейс
            gotoxy(2, 2);
            if newgame1.verify = true then write(inter[18].face[0], ': ', player.nickname);
            gotoxy(2, 3);
            write(inter[18].face[1]);
            //Ввод
            gotoxy(1, main.sizey - 1);write(' : ');
            readln(newgame1.input);
            //Проверка
            if newgame1.input = '0' then newgame1.output := 0;
            if (newgame1.input <> '0') then newgame1.output := 1;
            if (newgame1.input <> '0') and (newgame1.input.Length < 3) then newgame1.output := 2;
            if (newgame1.input <> '0') and (newgame1.input.Length > 15) then newgame1.output := 3;
            //Действие
            if newgame1.output = 0 then newgame1.status := false;
            if newgame1.output = 1 then
            begin
              newgame1.status := false;
              player.nickname := newgame1.input;
              newgame1.verify := true;
            end;
            if newgame1.output = 2 then
            begin
              console.ForegroundColor := consolecolor.Red;
              gotoxy(2, 4);write(inter[18].face[2]);
              console.ForegroundColor := main.fore;
              sleep(2000);
            end;
            if newgame1.output = 3 then
            begin
              console.ForegroundColor := consolecolor.Red;
              gotoxy(2, 4);write(inter[18].face[3]);
              console.ForegroundColor := main.fore;
              sleep(2000);
            end;
          end;
        end;
        if newgame.output = 3 then
        begin
          newgame2.status := true;
          while newgame2.status = true do
          begin
            Console.Clear;
            newgame2.output := dump;
            //Интерфейс
            gotoxy(2, 2);
            if newgame2.verify = true then
            begin
              write(inter[19].face[0], ': ');
              if date.day < 10 then write('0', date.day) else write(date.day);
              write('.');
              if date.month < 10 then write('0', date.month) else write(date.month);
              write('.', date.year);
            end;
            gotoxy(2, 3);write('(1) ', inter[19].face[1]);
            gotoxy(2, 4);write('(0) ', inter[19].face[2]);
            //Ввод
            gotoxy(1, main.sizey - 1);write(' : ');
            readln(newgame2.input);
            //Проверка
            if newgame2.input = '0' then newgame2.output := 0;
            if newgame2.input = '1' then newgame2.output := 1;
            //Действие
            if newgame2.output = 0 then newgame2.status := false;
            if newgame2.output = 1 then
            begin
              date.day := pabcsystem.Random(28) + 1;
              date.month := pabcsystem.Random(12) + 1;
              date.year := pabcsystem.Random(10) + 2008;
              date.hour := 10;
              newgame2.verify := true;
            end;
          end;
        end;
        if newgame.output = 4 then
        begin
          newgame3.status := true;
          while newgame3.status = true do
          begin
            Console.Clear;
            newgame3.output := dump;
            //Интерфейс
            gotoxy(2, 2);
            if newgame3.verify = true then
            begin
              write(inter[20].face[0], ': ', map[player.position].sortstr, ' ', map[player.position].name);
            end;
            gotoxy(2, 3);write('(1) ', inter[20].face[1]);
            gotoxy(2, 4);write('(2) ', inter[20].face[2]);
            gotoxy(2, 5);write('(3) ', inter[20].face[3]);
            gotoxy(2, 6);write('(0) ', inter[20].face[4]);
            //Ввод
            gotoxy(1, main.sizey - 1);
            write(' : ');
            readln(newgame3.input);
            //Проверка
            if newgame3.input = '0' then newgame3.output := 0;
            if newgame3.input = '1' then newgame3.output := 1;
            if newgame3.input = '2' then newgame3.output := 2;
            if newgame3.input = '3' then newgame3.output := 3;
            //Действие
            if newgame3.output = 0 then newgame3.status := false;
            if newgame3.output = 1 then
            begin
              newgame3.max := 1;
              for var i := 1 to towns do
              begin
                if map[i].sort = 3 then
                begin
                  newgame3.arr[newgame3.max] := i;
                  inc(newgame3.max);
                end;
              end;
              player.position := newgame3.arr[pabcsystem.Random(newgame3.max - 1) + 1];
              newgame3.verify := true;
            end;
            if newgame3.output = 2 then
            begin
              newgame3.max := 1;
              for var i := 1 to towns do
              begin
                if map[i].sort = 4 then
                begin
                  newgame3.arr[newgame3.max] := i;
                  inc(newgame3.max);
                end;
              end;
              player.position := newgame3.arr[pabcsystem.Random(newgame3.max - 1) + 1];
              newgame3.verify := true;
            end;
            if newgame3.output = 3 then
            begin
              newgame3.max := 1;
              for var i := 1 to towns do
              begin
                if map[i].sort = 5 then
                begin
                  newgame3.arr[newgame3.max] := i;
                  inc(newgame3.max);
                end;
              end;
              player.position := newgame3.arr[pabcsystem.Random(newgame3.max - 1) + 1];
              newgame3.verify := true;
            end;
          end;
        end;
      end;
    end;
    if menu.output = 2 then
    begin
      game.status := true;
      while game.status = true do
      begin
        if save.autosave = true then saver;
        resize;
        Console.Clear;
        game.output := dump;
        //Интерфейс
        upface;
        if bike.status = true then
        begin
          wnd(2, 3, 40, 4, inter[4].face[0]);
          gotoxy(4, 4);write(inter[4].face[1], ': ', bike.name);
          gotoxy(4, 5);write(inter[4].face[2], ': ', bike.speed, ' ', inter[4].face[3]);
          gotoxy(4, 6);write(inter[4].face[5], ': ', bike.trickmax);
        end
        else
        begin
          wnd(2, 3, 40, 4, inter[4].face[4]);
        end;
        gotoxy(2, main.sizey - 9);write('(1) ', inter[3].face[6]);
        gotoxy(2, main.sizey - 8);
        if (map[player.position].sort <> 1) then
        begin
          write('(2) ', inter[3].face[5]);
        end
        else
        begin
          Console.ForegroundColor := ConsoleColor.Gray;
          write('(2) ', inter[3].face[5]);
          Console.ForegroundColor := main.fore;
        end;
        gotoxy(2, main.sizey - 7);
        if (map[player.position].sort > 2) and (map[player.position].sort < 7) and (energy.value <> 0) and (bike.status=true) then
        begin
          write('(3) ', inter[3].face[4]);
        end
        else
        begin
          Console.ForegroundColor := ConsoleColor.Gray;
          write('(3) ', inter[3].face[4]);
          Console.ForegroundColor := main.fore;
        end;
        gotoxy(2, main.sizey - 6);
        if (map[player.position].sort >= 7) and (player.tricklvl < tricks) then
        begin
          write('(4) ', inter[3].face[3]);
        end
        else
        begin
          Console.ForegroundColor := ConsoleColor.Gray;
          write('(4) ', inter[3].face[3]);
          Console.ForegroundColor := main.fore;
        end;
        gotoxy(2, main.sizey - 5);write('(5) ', inter[3].face[2]);
        gotoxy(2, main.sizey - 4);
        if map[player.position].sort = 9 then//заменить на 8 для стабильной работы
        begin
          write('(6) ', inter[3].face[1]);
        end
        else
        begin
          Console.ForegroundColor := ConsoleColor.Gray;
          write('(6) ', inter[3].face[1]);
          Console.ForegroundColor := main.fore;
        end;
        gotoxy(2, main.sizey - 3);write('(0) ', inter[3].face[0]);
        if (date.month > 9) then truck.town := 0;
        if truck.town > 0 then
        begin
          if player.position = truck.town then
          begin
            gotoxy(60, 3);write(inter[30].face[0]);
            gotoxy(61, 4);
            console.ForegroundColor := consolecolor.Green;
            write(map[truck.town].sortstr, ' ', map[truck.town].name);
            console.ForegroundColor := main.fore;
          end
            else
          begin
            gotoxy(60, 3);write(inter[30].face[0]);
            gotoxy(61, 4);
            console.ForegroundColor := consolecolor.red;
            write(map[truck.town].sortstr, ' ', map[truck.town].name);
            console.ForegroundColor := main.fore;
          end;
        end;
        //Ввод
        gotoxy(1, main.sizey - 1);write(' : ');
        readln(game.input);
        if pabcsystem.Random(3) = 0 then inc(date.minute);
        //Проверка
        if game.input = '0' then game.output := 0;
        if game.input = '1' then game.output := 1;
        if (game.input = '2') and (map[player.position].sort <> 1) then game.output := 2;
        if (game.input = '3') and (map[player.position].sort > 2) and (map[player.position].sort < 7) and (energy.value <> 0) and (bike.status=true) then game.output := 3;
        if (game.input = '4') and (map[player.position].sort >= 7) and (player.tricklvl < tricks) then game.output := 4;
        if game.input = '5' then game.output := 5;
        if (game.input = '6') and (map[player.position].sort = 9) then game.output := 6;
        //Действие
        if game.output = 0 then
        begin
          game.status := false;
          saver;
        end;
        if game.output = 1 then
        begin
          adv.status := true;
          while adv.status = true do
          begin
            Console.Clear;
            adv.output := dump;
            //Интерфейс
            upface;
            adv.verifyA := false;
            adv.verifyF := false;
            adv.verifyR := false;
            for var i := 1 to towns do
            begin
              if map[player.position].Aroad[i] = true then adv.verifyA := true;
              if map[player.position].Froad[i] = true then adv.verifyF := true;
              if map[player.position].Rroad[i] = true then adv.verifyR := true;
            end;
            gotoxy(2, 3);
            if energy.value < 3 then adv.verifyA := false;
            if (adv.verifyA = true) and (bike.status = true) then
            begin
              write('(1) ', inter[5].face[0]);
            end
            else
            begin
              Console.ForegroundColor := consolecolor.Gray;
              write('(1) ', inter[5].face[0]);
              Console.ForegroundColor := main.fore;
            end;
            gotoxy(2, 4);
            if adv.verifyR = true then
            begin
              write('(2) ', inter[5].face[1]);
            end
            else
            begin
              Console.ForegroundColor := consolecolor.Gray;
              write('(2) ', inter[5].face[1]);
              Console.ForegroundColor := main.fore;
            end;
            gotoxy(2, 5);
            if adv.verifyF = true then
            begin
              write('(3) ', inter[5].face[2]);
            end
            else
            begin
              Console.ForegroundColor := consolecolor.Gray;
              write('(3) ', inter[5].face[2]);
              Console.ForegroundColor := main.fore;
            end;
            gotoxy(2, 6);write('(0) ', inter[5].face[3]);
            //Ввод
            gotoxy(1, main.sizey - 1);write(' : ');
            readln(adv.input);
            //Проверка
            if adv.input = '0' then adv.output := 0;
            if (adv.input = '1') and (adv.verifyA = true) and (bike.status = true) then adv.output := 1;
            if (adv.input = '2') and (adv.verifyR = true) then adv.output := 2;
            if (adv.input = '3') and (adv.verifyF = true) then adv.output := 3;
            //Действие
            if adv.output = 0 then adv.status := false;
            if adv.output = 1 then
            begin
              adva.status := true;
              while adva.status = true do
              begin
                console.Clear;
                adva.output := dump;
                //Интерфейс
                upface;
                adva.maxt := 1;
                for var i := 1 to towns do
                begin
                  if map[player.position].Aroad[i] = true then
                  begin
                    gotoxy(2, adva.maxt + 2);
                    write('(', adva.maxt, ') ', map[i].sortstr, ' ', map[i].name);
                    adva.arr[adva.maxt] := i;
                    inc(adva.maxt);
                  end;
                end;
                gotoxy(2, adva.maxt + 2);write('(0) ', inter[5].face[3]);
                //Ввод
                gotoxy(1, main.sizey - 1);write(' : ');
                readln(adva.input);
                //Проверка=Действие
                val(adva.input, adva.output, adva.error);
                if adva.output = 0 then adva.status := false;
                if (adva.output > 0) and (adva.output <= adva.maxt) then
                begin
                  adva.curdst := 0;
                  adva.dst := round(sqrt(sqr(map[player.position].posx - map[adva.arr[adva.output]].posx) + sqr(map[player.position].posy - map[adva.arr[adva.output]].posy)) * kA);
                  while adva.curdst <= adva.dst do
                  begin
                    Console.Clear;
                    write(inter[6].face[0], ': ', adva.curdst, '/', adva.dst, ' ', inter[6].face[1]);
                    inc(adva.curdst);
                    sleep(round(1 / bike.speed * 1000));
                  end;
                  player.position := adva.arr[adva.output];
                  inc(date.minute, round(adva.dst / bike.speed * 60));
                  dec(energy.value, 3);
                  adva.status := false;
                  adv.status := false;
                  saver;
                end;
              end;
            end;
            if adv.output = 2 then
            begin
              advr.status := true;
              while advr.status = true do
              begin
                console.Clear;
                advr.output := dump;
                //Интерфейс
                upface;
                advr.maxt := 1;
                for var i := 1 to towns do
                begin
                  if map[player.position].Rroad[i] = true then
                  begin
                    gotoxy(2, advr.maxt + 2);
                    advr.arr[advr.maxt] := i;
                    advr.price[advr.maxt] := (round((sqrt(sqr(map[player.position].posx - map[advr.arr[advr.maxt]].posx) + sqr(map[player.position].posy - map[advr.arr[advr.maxt]].posy)) * kR) * KPR) div 10) * 10;
                    if player.money >= advr.price[advr.maxt] then
                    begin
                      write('(', advr.maxt, ') ', map[i].sortstr, ' ', map[i].name, ' (', (advr.price[advr.maxt]), ' ', inter[2].face[18], ')');
                    end
                    else
                    begin
                      console.ForegroundColor := consolecolor.Gray;
                      write('(', advr.maxt, ') ', map[i].sortstr, ' ', map[i].name, ' (', (advr.price[advr.maxt]), ' ', inter[2].face[18], ')');
                      console.ForegroundColor := main.fore;
                    end;
                    inc(advr.maxt);
                  end;
                end;
                gotoxy(2, advr.maxt + 2);write('(0) ', inter[5].face[3]);
                //Ввод
                gotoxy(1, main.sizey - 1);write(' : ');
                readln(advr.input);
                //Проверка=Действие
                val(advr.input, advr.output, advr.error);
                if advr.output = 0 then advr.status := false;
                if (advr.output > 0) and (advr.output <= advr.maxt) and (player.money >= advr.price[advr.output]) then
                begin
                  advr.curdst := 0;
                  advr.dst := 0;
                  advr.dst := round(sqrt(sqr(map[player.position].posx - map[advr.arr[advr.output]].posx) + sqr(map[player.position].posy - map[advr.arr[advr.output]].posy)) * kR);
                  while advr.curdst < advr.dst do
                  begin
                    Console.Clear;
                    write(inter[6].face[0], ': ', advr.curdst, '/', advr.dst, ' ', inter[6].face[1]);
                    inc(advr.curdst);
                    advr.speed := 40 + pabcsystem.Random(25);
                    sleep(round(1 / advr.speed * 1500));
                  end;
                  dec(player.money, advr.price[advr.output]);
                  player.position := advr.arr[advr.output];
                  inc(date.minute, round(advr.dst / 52.5 * 60));
                  advr.status := false;
                  adv.status := false;
                  saver;
                end;
              end;
            end;
            if adv.output = 3 then
            begin
              advf.status := true;
              while advf.status = true do
              begin
                console.Clear;
                advf.output := dump;
                //Интерфейс
                upface;
                advf.maxt := 1;
                for var i := 1 to towns do
                begin
                  if map[player.position].Froad[i] = true then
                  begin
                    gotoxy(2, advf.maxt + 2);
                    advf.arr[advf.maxt] := i;
                    advf.price[advf.maxt] := (round((sqrt(sqr(map[player.position].posx - map[advf.arr[advf.maxt]].posx) + sqr(map[player.position].posy - map[advf.arr[advf.maxt]].posy)) * kF) * KPF) div 10) * 10;
                    if player.money >= advf.price[advf.maxt] then
                    begin
                      write('(', advf.maxt, ') ', map[i].sortstr, ' ', map[i].name, ' (', (advf.price[advf.maxt]), ' ', inter[2].face[18], ')');
                    end
                    else
                    begin
                      console.ForegroundColor := Consolecolor.Gray;
                      write('(', advf.maxt, ') ', map[i].sortstr, ' ', map[i].name, ' (', (advf.price[advf.maxt]), ' ', inter[2].face[18], ')');
                      console.ForegroundColor := main.fore;
                    end;
                    inc(advf.maxt);
                  end;
                end;
                gotoxy(2, advf.maxt + 2);write('(0) ', inter[5].face[3]);
                //Ввод
                gotoxy(1, main.sizey - 1);write(' : ');
                readln(advf.input);
                //Проверка=Действие
                val(advf.input, advf.output, advf.error);
                if advf.output = 0 then advf.status := false;
                if (advf.output > 0) and (advf.output <= advf.maxt) and (player.money >= advf.price[advf.output]) then
                begin
                  advf.curdst := 0;
                  advf.dst := 0;
                  advf.dst := round(sqrt(sqr(map[player.position].posx - map[advf.arr[advf.output]].posx) + sqr(map[player.position].posy - map[advf.arr[advf.output]].posy)) * kF);
                  while advf.curdst < advf.dst do
                  begin
                    Console.Clear;
                    write(inter[6].face[2], ': ', advf.curdst, '/', advf.dst, ' ', inter[6].face[1]);
                    inc(advf.curdst, 3);
                    advf.speed := 200 + pabcsystem.Random(100);
                    sleep(round(1 / advf.speed * 3000 * 3));
                  end;
                  dec(player.money, advf.price[advf.output]);
                  player.position := advf.arr[advf.output];
                  inc(date.minute, round(advf.dst / 250 * 60));
                  advf.status := false;
                  adv.status := false;
                  saver;
                end;
              end;
            end;
          end;
        end;
        if game.output = 2 then
        begin
          shop.status := true;
          while shop.status = true do
          begin
            Console.Clear;
            shop.output := dump;
            //Интерфейс
            upface;
            if ((date.hour > map[player.position].shop_op_h) and (date.hour < map[player.position].shop_cl_h)) or
            ((map[player.position].shop_op_h = date.hour) and (date.minute >= map[player.position].shop_op_m)) or
            ((map[player.position].shop_cl_h = date.hour) and (date.minute < map[player.position].shop_cl_m)) or
            ((map[player.position].shop_op_h = map[player.position].shop_cl_h) and (map[player.position].shop_op_m = map[player.position].shop_cl_m)) then
            begin
              shop.verify := true;
              gotoxy(2, 3);write(inter[7].face[0], ': ');
              if ((map[player.position].shop_op_h = map[player.position].shop_cl_h) and (map[player.position].shop_op_m = map[player.position].shop_cl_m)) then write(inter[7].face[5])
              else
              begin
                if map[player.position].shop_op_h >= 10 then write(map[player.position].shop_op_h, ':') else write('0', map[player.position].shop_op_h, ':');
                if map[player.position].shop_op_m >= 10 then write(map[player.position].shop_op_m) else write('0', map[player.position].shop_op_m);
                write(' - ');
                if map[player.position].shop_cl_h >= 10 then write(map[player.position].shop_cl_h, ':') else write('0', map[player.position].shop_cl_h, ':');
                if map[player.position].shop_cl_m >= 10 then write(map[player.position].shop_cl_m) else write('0', map[player.position].shop_cl_m);
              end;
              gotoxy(2, 4);write('(1) ', inter[7].face[1]);
              if map[player.position].sort > 6 then
              begin
                gotoxy(2, 5);write('(2) ', inter[7].face[2]);
              end
              else
              begin
                Console.ForegroundColor := consolecolor.Gray;
                gotoxy(2, 5);write('(2) ', inter[7].face[2]);
                Console.ForegroundColor := main.fore;
              end;
              if bike.status = true then
              begin
                gotoxy(2, 6);write('(3) ', inter[7].face[3]);
              end
              else
              begin
                Console.ForegroundColor := consolecolor.Gray;
                gotoxy(2, 6);write('(3) ', inter[7].face[3]);
                Console.ForegroundColor := main.fore;
              end;
            end
            else
            begin
              shop.verify := false;
              gotoxy(2, 3);write(inter[7].face[0], ': ');
              console.ForegroundColor := consolecolor.Red;
              if map[player.position].shop_op_h >= 10 then write(map[player.position].shop_op_h, ':') else write('0', map[player.position].shop_op_h, ':');
              if map[player.position].shop_op_m >= 10 then write(map[player.position].shop_op_m) else write('0', map[player.position].shop_op_m);
              write(' - ');
              if map[player.position].shop_cl_h >= 10 then write(map[player.position].shop_cl_h, ':') else write('0', map[player.position].shop_cl_h, ':');
              if map[player.position].shop_cl_m >= 10 then write(map[player.position].shop_cl_m) else write('0', map[player.position].shop_cl_m);
              console.ForegroundColor := consolecolor.Gray;
              gotoxy(2, 4);write('(1) ', inter[7].face[1]);
              gotoxy(2, 5);write('(2) ', inter[7].face[2]);
              gotoxy(2, 6);write('(3) ', inter[7].face[3]);
              console.ForegroundColor := main.fore;
            end;
            gotoxy(2, 7);write('(0) ', inter[7].face[4]);
            //Ввод
            gotoxy(1, main.sizey - 1);write(' : ');
            readln(shop.input);
            //Проверка
            if shop.input = '0' then shop.output := 0;
            if (shop.input = '1') and (shop.verify = true) then shop.output := 1;
            if (shop.input = '2') and (shop.verify = true) and (map[player.position].sort > 6) then shop.output := 2;
            if (shop.input = '3') and (shop.verify = true) and (bike.status = true) then shop.output := 3;
            //Действие
            if shop.output = 0 then shop.status := false;
            if shop.output = 1 then
            begin
              shopbuy.status := true;
              shopbuy.restart := true;
              while shopbuy.status = true do
              begin
                Console.Clear;
                shopbuy.output := dump;
                //Интерфейс
                upface;
                if shopbuy.restart = true then
                begin
                  shopbuy.bike.name := inter[9].face[pabcsystem.Random(inter[9].face.Length - 1)];
                  shopbuy.bike.speed := 15 + pabcsystem.Random(11);
                  shopbuy.bike.maxtrick := 3 + pabcsystem.Random(round(tricks / 3));
                  shopbuy.bike.price := 5000 + (pabcsystem.Random(1000) * 10);
                  shopbuy.restart := false;
                end;
                wnd(2, 3, 40, 4, inter[10].face[0]);
                gotoxy(4, 4);write(inter[10].face[1], ': ', shopbuy.bike.name);
                gotoxy(4, 5);write(inter[10].face[2], ': ', shopbuy.bike.speed, ' ', inter[10].face[3]);
                gotoxy(4, 6);write(inter[10].face[4], ': ', shopbuy.bike.maxtrick);
                if (player.money >= shopbuy.bike.price) then
                begin
                  gotoxy(2, main.sizey - 5);write('(1) ', inter[10].face[5], ' (', shopbuy.bike.price, ')');
                end
                else
                begin
                  Console.ForegroundColor := ConsoleColor.Gray;
                  gotoxy(2, main.sizey - 5);write('(1) ', inter[10].face[5], ' (', shopbuy.bike.price, ')');
                  Console.ForegroundColor := main.fore;
                end;
                gotoxy(2, main.sizey - 4);write('(2) ', inter[10].face[6]);
                gotoxy(2, main.sizey - 3);write('(0) ', inter[10].face[7]);
                //Ввод
                gotoxy(1, main.sizey - 1);write(' : ');
                readln(shopbuy.input);
                //Проверка
                if shopbuy.input = '0' then shopbuy.output := 0;
                if (shopbuy.input = '1') and (player.money >= shopbuy.bike.price) then shopbuy.output := 1;
                if shopbuy.input = '2' then shopbuy.output := 2;
                //Действие
                if shopbuy.output = 0 then shopbuy.status := false;
                if shopbuy.output = 2 then shopbuy.restart := true;
                if shopbuy.output = 1 then
                begin
                  if bike.status = true then inc(player.money, bike.price);
                  bike.status := true;
                  bike.name := shopbuy.bike.name;
                  bike.speed := shopbuy.bike.speed;
                  bike.trickmax := shopbuy.bike.maxtrick;
                  bike.price := round(shopbuy.bike.price * 0.75);
                  Dec(player.money, shopbuy.bike.price);
                  shopbuy.status := false;
                  shop.status := false;
                end;
              end;
            end;
            if shop.output = 2 then
            begin
              shoporder.status := true;
              while shoporder.status = true do
              begin
                Console.Clear;
                shoporder.output := dump;
                //Интерфейс
                upface;
                gotoxy(2, 3);write(inter[24].face[0]);
                gotoxy(3, 4);
                if (shoporder1.verify = true) and (shoporder2.verify = true) and ((shoporder.bike.price + 5000) <= player.money) then
                begin
                  write('(1) ', inter[24].face[1], ' (', shoporder.bike.price + 5000, ')');
                end
                else
                begin
                  console.ForegroundColor := consolecolor.gray;
                  write('(1) ', inter[24].face[1], ' (', shoporder.bike.price + 5000, ')');
                  console.ForegroundColor := main.fore;
                end;
                gotoxy(3, 5);
                if (shoporder1.verify = true) then
                begin
                  write('(2) ', inter[24].face[2], ' (', shoporder.bike.name, ')');
                end
                else
                begin
                  console.ForegroundColor := consolecolor.red;
                  write('(2) ', inter[24].face[2]);
                  console.ForegroundColor := main.fore;
                end;
                gotoxy(3, 6);
                if (shoporder2.verify = true) then
                begin
                  write('(3) ', inter[24].face[3], ' (', inter[24].face[3 + shoporder2.sort], ')');
                end
                else
                begin
                  console.ForegroundColor := consolecolor.red;
                  write('(3) ', inter[24].face[3]);
                  console.ForegroundColor := main.fore;
                end;
                gotoxy(3, 7);write('(0) ', inter[24].face[9]);
                //Ввод
                gotoxy(1, main.sizey - 1);write(' : ');
                readln(shoporder.input);
                //Проверка
                if shoporder.input = '0' then shoporder.output := 0;
                if (shoporder.input = '1') and (shoporder1.verify = true) and (shoporder2.verify = true) and ((shoporder.bike.price + 5000) <= player.money) then shoporder.output := 1;
                if shoporder.input = '2' then shoporder.output := 2;
                if shoporder.input = '3' then shoporder.output := 3;
                //Действие
                if shoporder.output = 0 then shoporder.status := false;
                if shoporder.output = 1 then
                begin
                  shoporder1.verify := false;
                  shoporder2.verify := false;
                  shoporder.prog := 0;
                  while shoporder.prog <= 100 do
                  begin
                    Console.Clear;
                    write(inter[27].face[0], ': ', shoporder.prog, '%');
                    inc(shoporder.prog);
                    sleep(10);
                  end;
                  shoporder.prog := 0;
                  while shoporder.prog <= 100 do
                  begin
                    Console.Clear;
                    write(inter[27].face[1], ': ', shoporder.prog, '%');
                    inc(shoporder.prog);
                    sleep(20);
                  end;
                  shoporder.prog := 0;
                  while shoporder.prog <= 100 do
                  begin
                    Console.Clear;
                    write(inter[27].face[2], ': ', shoporder.prog, '%');
                    inc(shoporder.prog);
                    sleep(50);
                  end;
                  shoporder.prog := 0;
                  while shoporder.prog <= 100 do
                  begin
                    Console.Clear;
                    write(inter[27].face[3], ': ', shoporder.prog, '%');
                    inc(shoporder.prog);
                    sleep(20);
                  end;
                  dec(player.money, shoporder.bike.price + 5000);
                  inc(player.money, bike.price);
                  bike.status := true;
                  bike.name := shoporder.bike.name;
                  bike.speed := shoporder.bike.speed;
                  bike.trickmax := shoporder.bike.maxtrick;
                  bike.price := round((shoporder.bike.price + 5000) * 0.9);
                  shoporder.status := false;
                  shop.status := false;
                  shoporder.bike.price := 0;
                  shoporder2.sort := 0;
                end;
                if shoporder.output = 2 then
                begin
                  shoporder1.status := true;
                  while shoporder1.status = true do
                  begin
                    console.Clear;
                    shoporder1.output := dump;
                    //Интерфейс
                    gotoxy(2, 2);
                    if shoporder1.verify = true then
                    begin
                      write(inter[25].face[0], ': ', shoporder.bike.name);
                    end;
                    gotoxy(2, 3);write(inter[25].face[1]);
                    //Ввод
                    gotoxy(1, main.sizey - 1);write(' : ');
                    readln(shoporder1.input);
                    //Проверка
                    if shoporder1.input = '0' then shoporder1.output := 0;
                    if shoporder1.input <> '0' then shoporder1.output := 1;
                    if (shoporder1.input <> '0') and (shoporder1.input.Length < 3) then shoporder1.output := 2;
                    if (shoporder1.input <> '0') and (shoporder1.input.Length > 20) then shoporder1.output := 3;
                    //Действие
                    if shoporder1.output = 0 then shoporder1.status := false;
                    if shoporder1.output = 1 then
                    begin
                      shoporder.bike.name := shoporder1.input;
                      shoporder1.verify := true;
                    end;
                    if shoporder1.output = 2 then
                    begin
                      Console.ForegroundColor := consolecolor.Red;
                      gotoxy(2, 4);write(inter[25].face[2]);
                      Console.ForegroundColor := main.fore;
                    end;
                    if shoporder1.output = 3 then
                    begin
                      Console.ForegroundColor := consolecolor.Red;
                      gotoxy(2, 4);write(inter[25].face[3]);
                      Console.ForegroundColor := main.fore;
                    end;
                  end;
                end;
                if shoporder.output = 3 then
                begin
                  shoporder2.status := true;
                  while shoporder2.status = true do
                  begin
                    Console.Clear;
                    shoporder2.output := dump;
                    //Интерфейс
                    gotoxy(2, 2);
                    if shoporder2.verify = true then
                    begin
                      write(inter[26].face[0], ': ', inter[24].face[3 + shoporder2.sort]);
                    end;
                    if player.money >= 10000 then
                    begin
                      gotoxy(2, 3);write('(1) ', inter[26].face[1]);
                    end
                    else
                    begin
                      Console.ForegroundColor := consolecolor.Gray;
                      gotoxy(2, 3);write('(1) ', inter[26].face[1]);
                      Console.ForegroundColor := main.fore;
                    end;
                    if player.money >= 15000 then
                    begin
                      gotoxy(2, 4);write('(2) ', inter[26].face[2]);
                    end
                    else
                    begin
                      Console.ForegroundColor := consolecolor.Gray;
                      gotoxy(2, 4);write('(2) ', inter[26].face[2]);
                      Console.ForegroundColor := main.fore;
                    end;
                    if player.money >= 30000 then
                    begin
                      gotoxy(2, 5);write('(3) ', inter[26].face[3]);
                    end
                    else
                    begin
                      Console.ForegroundColor := consolecolor.Gray;
                      gotoxy(2, 5);write('(3) ', inter[26].face[3]);
                      Console.ForegroundColor := main.fore;
                    end;
                    if player.money >= 40000 then
                    begin
                      gotoxy(2, 6);write('(4) ', inter[26].face[4]);
                    end
                    else
                    begin
                      Console.ForegroundColor := consolecolor.Gray;
                      gotoxy(2, 6);write('(4) ', inter[26].face[4]);
                      Console.ForegroundColor := main.fore;
                    end;
                    if player.money >= 70000 then
                    begin
                      gotoxy(2, 7);write('(5) ', inter[26].face[5]);
                    end
                    else
                    begin
                      Console.ForegroundColor := consolecolor.Gray;
                      gotoxy(2, 7);write('(5) ', inter[26].face[5]);
                      Console.ForegroundColor := main.fore;
                    end;
                    gotoxy(2, 8);write('(0) ', inter[26].face[6]);
                    //Ввод
                    gotoxy(1, main.sizey - 1);write(' : ');
                    readln(shoporder2.input);
                    //Проверка
                    if shoporder2.input = '0' then shoporder2.output := 0;
                    if (shoporder2.input = '1') and (player.money >= 10000) then shoporder2.output := 1;
                    if (shoporder2.input = '2') and (player.money >= 15000) then shoporder2.output := 2;
                    if (shoporder2.input = '3') and (player.money >= 30000) then shoporder2.output := 3;
                    if (shoporder2.input = '4') and (player.money >= 40000) then shoporder2.output := 4;
                    if (shoporder2.input = '5') and (player.money >= 60000) then shoporder2.output := 5;
                    //Действие
                    if shoporder2.output = 0 then shoporder2.status := false;
                    if shoporder2.output = 1 then
                    begin
                      shoporder2.verify := true;
                      shoporder2.sort := 1;
                      shoporder.bike.price := 5000;
                      shoporder.bike.speed := 20;
                      shoporder.bike.maxtrick := 3;
                    end;
                    if shoporder2.output = 2 then
                    begin
                      shoporder2.verify := true;
                      shoporder2.sort := 2;
                      shoporder.bike.price := 10000;
                      shoporder.bike.speed := 25;
                      shoporder.bike.maxtrick := 5;
                    end;
                    if shoporder2.output = 3 then
                    begin
                      shoporder2.verify := true;
                      shoporder2.sort := 3;
                      shoporder.bike.price := 25000;
                      shoporder.bike.speed := 50;
                      shoporder.bike.maxtrick := 5;
                    end;
                    if shoporder2.output = 4 then
                    begin
                      shoporder2.verify := true;
                      shoporder2.sort := 4;
                      shoporder.bike.price := 35000;
                      shoporder.bike.speed := 30;
                      shoporder.bike.maxtrick := 9;
                    end;
                    if shoporder2.output = 5 then
                    begin
                      shoporder2.verify := true;
                      shoporder2.sort := 5;
                      shoporder.bike.price := 55000;
                      shoporder.bike.speed := 35;
                      shoporder.bike.maxtrick := 15;
                    end;
                  end;
                end;
              end;
            end;
            if shop.output = 3 then
            begin
              shopsale.status := true;
              while shopsale.status = true do
              begin
                console.Clear;
                shopsale.output := dump;
                //Интерфейс
                upface;
                gotoxy(2, 3);write(inter[11].face[0], ' ', bike.name, '?');
                gotoxy(2, 4);write(inter[11].face[1], ': ', bike.price);
                spc;
                case bike.price mod 100 of
                  1, 21, 31, 41, 51, 61, 71, 81, 91: write(inter[2].face[16]);
                  2..4, 22..24, 32..34, 42..44, 52..54, 62..64, 72..74, 82..84, 92..94: write(inter[2].face[17]);
                  0, 5..20, 25..30, 35..40, 45..50, 55..60, 65..70, 75..80, 85..90, 95..99: write(inter[2].face[18]);
                end;
                spc;
                gotoxy(2, 5);write('(1) ', inter[11].face[2]);
                gotoxy(2, 6);write('(0) ', inter[11].face[3]);
                //Ввод
                gotoxy(1, main.sizey - 1);write(' : ');
                readln(shopsale.input);
                //Проверка
                if shopsale.input = '0' then shopsale.output := 0;
                if shopsale.input = '1' then shopsale.output := 1;
                //Действие
                if shopsale.output = 0 then shopsale.status := false;
                if shopsale.output = 1 then
                begin
                  shopsale.status := false;
                  bike.status := false;
                  inc(player.money, bike.price);
                  if save.autosave = true then saver;
                end;
              end;
            end;
          end;
        end;
        if game.output = 3 then
        begin
          truck.status := true;
          while truck.status = true do
          begin
            if save.autosave = true then saver;
            Console.Clear;
            truck.output := dump;
            //Интерфейс
            upface;
            truck.max := 1;
            if truck.town = player.position then
            begin
              truck.sizer := 3;
              gotoxy(2, 3);
              console.ForegroundColor := consolecolor.Green;
              write(inter[30].face[1]);
              console.ForegroundColor := main.fore;
            end
            else truck.sizer := 2;
            if player.tricklvl <= bike.trickmax then
            begin
              for var i := 1 to player.tricklvl do
              begin
                gotoxy(2, i + truck.sizer);write('(', i, ') ', trick[i].name);
                if truck.town = player.position then
                begin
                  console.ForegroundColor := consolecolor.green;
                  write(' (~', (trick[i].price + round(trick[i].rprice / 2)) * player.trickindex * 3:0:0, ')');
                  console.ForegroundColor := main.fore;
                end
                else write(' (~', (trick[i].price + round(trick[i].rprice / 2)) * player.trickindex:0:0, ')');
                inc(truck.max);
              end;
              gotoxy(2, truck.max + truck.sizer);write('(0) ', inter[15].face[0]);
            end
            else
            begin
              for var i := 1 to bike.trickmax do
              begin
                gotoxy(2, i + truck.sizer);write('(', i, ') ', trick[i].name);
                if truck.town = player.position then
                begin
                  console.ForegroundColor := consolecolor.green;
                  write(' (~', (trick[i].price + round(trick[i].rprice / 2)) * player.trickindex * 3:0:0, ')');
                  console.ForegroundColor := main.fore;
                end
                else write(' (~', (trick[i].price + round(trick[i].rprice / 2)) * player.trickindex:0:0, ')');
                inc(truck.max);
              end;
              gotoxy(2, truck.max + truck.sizer);write('(0) ', inter[15].face[0]);
            end;
            //Ввод
            gotoxy(1, main.sizey - 1);write(' : ');
            readln(truck.input);
            val(truck.input, truck.output, truck.error);
            //Действие
            if truck.output = 0 then truck.status := false;
            if (truck.output > 0) and (truck.output < truck.max) then
            begin
              Console.Clear;
              truck.prog := 0;
              while truck.prog <= 100 do
              begin
                Console.Clear;
                write(trick[truck.output].name, ': ', truck.prog, '%');
                inc(truck.prog, 3);
                sleep(25);
              end;
              Dec(energy.value);
              Inc(date.minute, 30 + pabcsystem.Random(30));
              if truck.town = player.position then Inc(date.minute, 30 + pabcsystem.Random(30));
              truck.price := round((trick[truck.output].price + pabcsystem.Random(trick[truck.output].rprice)) * player.trickindex);
              if (truck.town = player.position) then
              begin
                if energy.value > 0 then truck.price := truck.price * 3 else truck.price := round(truck.price * 1.5);
                if energy.value > 0 then Dec(energy.value);
              end;
              Inc(player.money, truck.price);
              player.trickindex :=  player.trickindex + 0.0004;
              Console.Clear;write(inter[15].face[1], ': ', truck.price);
              spc;
              case truck.price mod 100 of
                1, 21, 31, 41, 51, 61, 71, 81, 91: write(inter[2].face[16]);
                2..4, 22..24, 32..34, 42..44, 52..54, 62..64, 72..74, 82..84, 92..94: write(inter[2].face[17]);
                0, 5..20, 25..30, 35..40, 45..50, 55..60, 65..70, 75..80, 85..90, 95..99: write(inter[2].face[18]);
              end;
              spc;
              sleep(500);
              if energy.value = 0 then truck.status := false;
            end;
          end;
        end;
        if game.output = 4 then
        begin
          school.status := true;
          while school.status = true do
          begin
            if save.autosave = true then saver;
            console.Clear;
            school.output := dump;
            //Интерфейс
            upface;
            gotoxy(2, 3);write(inter[21].face[0], ': ', player.tricklvl);
            gotoxy(2, 4);
            if trick[player.tricklvl + 1].sprice <= player.money then
            begin
              write('(1) ', inter[21].face[1], ' (', trick[player.tricklvl + 1].sprice, ')');
            end
            else
            begin
              console.ForegroundColor := consolecolor.Gray;
              write('(1) ', inter[21].face[1], ' (', trick[player.tricklvl + 1].sprice, ')');
              console.ForegroundColor := main.fore;
            end;
            gotoxy(2, 5);write('(0) ', inter[21].face[2]);
            //Ввод
            gotoxy(1, main.sizey - 1);write(' : ');
            readln(school.input);
            //Проверка
            if school.input = '0' then school.output := 0;
            if (school.input = '1') and (trick[player.tricklvl + 1].sprice <= player.money) then school.output := 1;
            //Действие
            if school.output = 0 then school.status := false;
            if school.output = 1 then
            begin
              school.prog := 0;
              dec(player.money, trick[player.tricklvl + 1].sprice);
              inc(player.tricklvl);
              while school.prog <= 100 do
              begin
                Console.Clear;
                write(inter[21].face[3], ' "', trick[player.tricklvl].name, '": ', school.prog, '%');
                inc(school.prog);
                sleep(100);
              end;
            end;
          end;
        end;
        if game.output = 5 then
        begin
          relax.status := true;
          while relax.status = true do
          begin
            if save.autosave = true then saver;
            Console.Clear;
            relax.output := dump;
            //Интерфейс
            upface;
            gotoxy(2, 3);write(inter[23].face[0], '?');
            gotoxy(2, 4);write('(1) ', inter[23].face[1]);
            gotoxy(2, 5);write('(2) ', inter[23].face[2]);
            gotoxy(2, 6);write('(3) ', inter[23].face[3]);
            gotoxy(2, 7);write('(4) ', inter[23].face[4], ' ');
            console.ForegroundColor := consolecolor.Red;
            write(inter[29].face[0]);
            console.ForegroundColor := main.fore;
            gotoxy(2, 8);write('(5) ', inter[23].face[5], ' ');
            console.ForegroundColor := consolecolor.Red;
            write(inter[29].face[1]);
            console.ForegroundColor := main.fore;
            gotoxy(2, 9);write('(6) ', inter[23].face[6], ' ');
            console.ForegroundColor := consolecolor.Red;
            write(inter[29].face[2]);
            console.ForegroundColor := main.fore;
            gotoxy(2, 10);write('(7) ', inter[23].face[7], ' ');
            console.ForegroundColor := consolecolor.Red;
            write(inter[29].face[3]);
            console.ForegroundColor := main.fore;
            gotoxy(2, 11);write('(8) ', inter[23].face[8], ' ');
            console.ForegroundColor := consolecolor.Red;
            write(inter[29].face[4]);
            console.ForegroundColor := main.fore;
            gotoxy(2, 12);write('(9) ', inter[23].face[9], ' ');
            console.ForegroundColor := consolecolor.Red;
            write(inter[29].face[5]);
            console.ForegroundColor := main.fore;
            gotoxy(2, 13);write('(0) ', inter[23].face[10]);
            //Ввод
            gotoxy(1, main.sizey - 1);write(' : ');
            readln(relax.input);
            //Проверка
            if relax.input = '0' then relax.output := 0;
            if relax.input = '1' then relax.output := 1;
            if relax.input = '2' then relax.output := 2;
            if relax.input = '3' then relax.output := 3;
            if relax.input = '4' then relax.output := 4;
            if relax.input = '5' then relax.output := 5;
            if relax.input = '6' then relax.output := 6;
            if relax.input = '7' then relax.output := 7;
            if relax.input = '8' then relax.output := 8;
            if relax.input = '9' then relax.output := 9;
            //Действие
            if relax.output = 0 then relax.status := false;
            if relax.output = 1 then
            begin
              relax.prog := 0;
              while relax.prog < 100 do
              begin
                console.Clear;
                write(inter[23].face[11], ': ', relax.prog, '%');
                inc(relax.prog);
                sleep(20);
              end;
              inc(date.minute, 10);
            end;
            if relax.output = 2 then
            begin
              relax.prog := 0;
              while relax.prog < 100 do
              begin
                console.Clear;
                write(inter[23].face[11], ': ', relax.prog, '%');
                inc(relax.prog);
                sleep(20);
              end;
              inc(date.minute, 20);
            end;
            if relax.output = 3 then
            begin
              relax.prog := 0;
              while relax.prog < 100 do
              begin
                console.Clear;
                write(inter[23].face[11], ': ', relax.prog, '%');
                inc(relax.prog);
                sleep(20);
              end;
              inc(date.minute, 30);
            end;
            if relax.output = 4 then
            begin
              relax.prog := 0;
              while relax.prog < 100 do
              begin
                console.Clear;
                write(inter[23].face[11], ': ', relax.prog, '%');
                inc(relax.prog);
                sleep(20);
              end;
              inc(date.minute, 60);
              if energy.value < energy.max then inc(energy.value, 1)
              else energy.value := 10;
              if energy.value = 10 then relax.status := false;
            end;
            if relax.output = 5 then
            begin
              relax.prog := 0;
              while relax.prog < 100 do
              begin
                console.Clear;
                write(inter[23].face[11], ': ', relax.prog, '%');
                inc(relax.prog);
                sleep(20);
              end;
              inc(date.minute, 120);
              if energy.value + 1 < energy.max then inc(energy.value, 2)
              else energy.value := 10;
              if energy.value = 10 then relax.status := false;
            end;
            if relax.output = 6 then
            begin
              relax.prog := 0;
              while relax.prog < 100 do
              begin
                console.Clear;
                write(inter[23].face[11], ': ', relax.prog, '%');
                inc(relax.prog);
                sleep(20);
              end;
              inc(date.minute, 240);
              if energy.value + 3 < energy.max then inc(energy.value, 4)
              else energy.value := 10;
              if energy.value = 10 then relax.status := false;
            end;
            if relax.output = 7 then
            begin
              relax.prog := 0;
              while relax.prog < 100 do
              begin
                console.Clear;
                write(inter[23].face[11], ': ', relax.prog, '%');
                inc(relax.prog);
                sleep(20);
              end;
              if energy.value + 6 < energy.max then inc(energy.value, 6)
              else energy.value := 10;
              inc(date.minute, 360);
              if energy.value = 10 then relax.status := false;
            end;
            if relax.output = 8 then
            begin
              relax.prog := 0;
              while relax.prog < 100 do
              begin
                console.Clear;
                write(inter[23].face[11], ': ', relax.prog, '%');
                inc(relax.prog);
                sleep(20);
              end;
              energy.value := energy.max;
              inc(date.minute, 720);
              if energy.value = 10 then relax.status := false;
            end;
            if relax.output = 9 then
            begin
              relax.prog := 0;
              while relax.prog < 100 do
              begin
                console.Clear;
                write(inter[23].face[11], ': ', relax.prog, '%');
                inc(relax.prog);
                sleep(20);
              end;
              energy.value := energy.max;
              inc(date.minute, 1440);
              if energy.value = 10 then relax.status := false;
            end;
          end;
        end;
        if game.output = 6 then
        begin
          turnir.status := true;
          while turnir.status = true do
          begin
            turnir.output := dump;
            console.Clear;
            //Интерфейс
            upface;
            gotoxy(2, 3);write(inter[31].face[0], ': ');
            if turnir.stage = 1 then write(inter[31].face[1]);
            if turnir.stage = 1 then write(inter[31].face[2]);
            if turnir.stage = 2 then write(inter[31].face[3]);
            if turnir.stage = 3 then write(inter[31].face[4]);
            gotoxy(2, main.sizey-4);write('(1) ',inter[31].face[5]);
            console.ForegroundColor:=consolecolor.Red;
            if energy.value<10 then write(' (',inter[31].face[7],')');
            console.ForegroundColor:=main.fore;
            gotoxy(2, main.sizey-3);write('(0) ',inter[31].face[6]);
            //Ввод
            gotoxy(1, main.sizey - 1);write(' : ');
            readln(turnir.input);
            //Проверка
            if turnir.input = '0' then turnir.output := 0;
            //Действие
            if turnir.output = 0 then turnir.status := false;
          end;
        end;
      end;
    end;
    if menu.output = 3 then
    begin
      setup.status := true;
      while setup.status = true do
      begin
        setup.verify := false;
        Console.Clear;
        setup.output := dump;
        //Интерфейс
        gotoxy(2, 2);write('(1) ', inter[28].face[0], ': ');
        if save.status = true then
        begin
          if save.autosave = true then
          begin
            console.ForegroundColor := consolecolor.Green;
            write(inter[28].face[1]);
            console.ForegroundColor := main.fore;
          end
          else
          begin
            console.ForegroundColor := consolecolor.red;
            write(inter[28].face[2]);
            console.ForegroundColor := main.fore;
          end;
        end
        else
        begin
          console.ForegroundColor := consolecolor.gray;
          write(inter[28].face[7]);
          console.ForegroundColor := main.fore;
        end;
        gotoxy(2, 3);write('(2) ', inter[28].face[3], ': ');
        if save.status = true then
        begin
          if energy.text = true then
          begin
            write(inter[28].face[4]);
          end
          else
          begin
            write(inter[28].face[5]);
          end;
        end
        else
        begin
          console.ForegroundColor := consolecolor.gray;
          write(inter[28].face[7]);
          console.ForegroundColor := main.fore;
        end;
        gotoxy(2, 4);write('(0) ', inter[28].face[6]);
        //Ввод
        gotoxy(1, main.sizey - 1);write(' : ');
        readln(setup.input);
        //Проверка
        if setup.input = '0' then setup.output := 0;
        if setup.input = '1' then setup.output := 1;
        if setup.input = '2' then setup.output := 2;
        //Действие
        if setup.output = 0 then setup.status := false;
        if setup.output = 1 then
        begin
          if (save.autosave = true) and (setup.verify = false) then
          begin
            save.autosave := false;
            setup.verify := true;
          end;
          if (save.autosave = false) and (setup.verify = false) then
          begin
            save.autosave := true;
            setup.verify := true;
          end;
        end;
        if setup.output = 2 then
        begin
          if (energy.text = true) and (setup.verify = false) then
          begin
            energy.text := false;
            setup.verify := true;
          end;
          if (energy.text = false) and (setup.verify = false) then
          begin
            energy.text := true;
            setup.verify := true;
          end;
        end;
      end;
    end;
    if save.status = true then saver;
  end;
end.