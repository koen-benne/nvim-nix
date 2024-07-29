if vim.g.did_load_alpha_plugin then
  return
end
vim.g.did_load_alpha_plugin = true

local status_ok, alpha = pcall(require, 'alpha')
if not status_ok then
  return
end

local asciiTable = {
  [0] = {
    '⣿⣿⣿⣿⣿⡿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣿⣿⣿⣿',
    '⣿⣿⣿⣿⡏⣀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿',
    '⣿⣿⣿⢏⣴⣿⣷⠀⠀⠀⠀⠀⢾⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿',
    '⣿⣿⣟⣾⣿⡟⠁⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣷⢢⠀⠀⠀⠀⠀⠀⠀⢸⣿',
    '⣿⣿⣿⣿⣟⠀⡴⠄⠀⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⣿',
    '⣿⣿⣿⠟⠻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠶⢴⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⣿',
    '⣿⣁⡀⠀⠀⢰⢠⣦⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⡄⠀⣴⣶⣿⡄⣿',
    '⣿⡋⠀⠀⠀⠎⢸⣿⡆⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⠗⢘⣿⣟⠛⠿⣼',
    '⣿⣿⠋⢀⡌⢰⣿⡿⢿⡀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣧⢀⣼',
    '⣿⣿⣷⢻⠄⠘⠛⠋⠛⠃⠀⠀⠀⠀⠀⢿⣧⠈⠉⠙⠛⠋⠀⠀⠀⣿⣿⣿⣿⣿',
    '⣿⣿⣧⠀⠈⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠟⠀⠀⠀⠀⢀⢃⠀⠀⢸⣿⣿⣿⣿',
    '⣿⣿⡿⠀⠴⢗⣠⣤⣴⡶⠶⠖⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡸⠀⣿⣿⣿⣿',
    '⣿⣿⣿⡀⢠⣾⣿⠏⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠉⠀⣿⣿⣿⣿',
    '⣿⣿⣿⣧⠈⢹⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿',
    '⣿⣿⣿⣿⡄⠈⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⣿⣿⣿',
    '⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿',
    '⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿',
    '⣿⣿⣿⣿⣿⣦⣄⣀⣀⣀⣀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿',
  },
  {
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⢰⡰⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⣀⡪⣲⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⣆⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⡜⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⢹⠀⠀⠀⢀⡠⠒⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠤⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣀⡀⠀⠁⣟⡆⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠸⣶⣄⡠⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢎⣲⢖⡐⣶⠬⣢⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠲⠢⣶⣿⠇⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⡟⠁⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠇⠁⣀⠯⠍⡂⠈⠃⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠀⢻⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⢸⡆⠀⠀⠀⠀⠀⠐⠒⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣆⣴⡀⣙⣛⠁⣀⣰⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀  ⠀ ⠀⠤⠀⠀⠀⠀⠀⠀⠠⡏⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⢳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⠓⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠃⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠈⢳⣴⠄⠀⣀⠀⠀⠀⠀⠀⠀⠠⠂⠀⠀⠀⠀⠀⠤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⢠⣛⢿⣿⣿⣿⡿⢿⣏⠁⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠈⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⣀⣴⣶⠃⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣟⣥⠶⠄⠀⠀⠀⠀⠀⠀⠐⠾⣿⡾⠦⠀⠰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠐⠋⠉⠉⠁⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⣶⡄⠀⢈⣀⣆⡔⠀⠀⠀⠀⠋⣤⣻⣍⣿⣿⣶⠞⠁⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⡋⠀⡠⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠁⠀⠠⢝⠽⠏⠄⢠⡤⢀⡤⠊⠁⣉⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠹⣿⣧⣖⡀⠀⠀⠀⠀⠀⠀⢀⣤⣦⣤⣿⣿⣧⣄⠄⡠⡄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣴⣾⠥⠄⠀⠀⠈⢯⣷⣿⣗⢠⣽⣿⣿⢏    ⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⡟⢠⠀⡀⠠⣠⣤⣼⣿⣿⣿⣿⣿⣿⣿⣸⣿⠁⠀⢀⠀⣀⣀⣀⣀⠄⠀⣺⣦⣄⣀⣀⢄⡄⡼⣽⣴⣿⣿⣿⣿⣿⣿⣴⣦⡶⣠⣚⣹⠋⢰⢛⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠈⠻⣿⣿⣷⣿⣿⣿⣿⣿⣿⡟⢸⣿⣿⣿⣿⣿⣷⣦⣴⣶⣿⡿⠟⠛⠁⠀⠁⠈⠙⠛⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⠻⣿⣿⣿⣿⣿⣿⣿⣫⣴⣮⣵⣽⡯⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠈⠻⠿⣿⣿⣿⣿⣿⠏⠀⠄⠈⢻⡿⢿⣿⣿⠿⠛⠉⠁⠀⠀⠀⢀⡀⠀⠀⠀⠀⠘⠠⠈⡛⠻⢿⣿⡛⠿⣡⠄⢀⠀⠈⠙⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    ' ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣧⣷⣦⢀⣅⣤⣴⡦⣀⣥⣶⣶⣧⠖⡠⠁⠂⡀⢦⢤⡀⢀⠀⠀⢀⡈⠀⢂⣘⡢⡀⢀⡐⣶⣶⡤⡎⠉⠉⠋⠉⠁⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀      ⠀⠀⠻⣿⣽⣿⣾⣯⣩⣵⣿⡛⠿⣟⣁⣠⣠⣔⡆⣦⣽⣾⣯⣞⠲⠆⢖⣾⣷⣆⣍⡙⢻⣦⣦⣾⣮⣻⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣤⣬⣿⣥⣿⠽⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠈⠉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠉⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '                      ⠀⠀⠀⠀⠀ ⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀                             ⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀         ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                ⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏               ⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿                                ',
  },
  {
    '            :h-                                  Nhy`               ',
    '           -mh.                           h.    `Ndho               ',
    '           hmh+                          oNm.   oNdhh               ',
    '          `Nmhd`                        /NNmd  /NNhhd               ',
    '          -NNhhy                      `hMNmmm`+NNdhhh               ',
    '          .NNmhhs              ```....`..-:/./mNdhhh+               ',
    '           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ',
    '           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ',
    '      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ',
    ' .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ',
    ' h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ',
    ' hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ',
    ' /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ',
    '  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ',
    '   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ',
    '     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ',
    '       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ',
    '       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ',
    '       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ',
    '       //+++//++++++////+++///::--                 .::::-------::   ',
    '       :/++++///////////++++//////.                -:/:----::../-   ',
    '       -/++++//++///+//////////////               .::::---:::-.+`   ',
    '       `////////////////////////////:.            --::-----...-/    ',
    '        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ',
    '         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ',
    '           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ',
    '            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``',
    '           s-`::--:::------:////----:---.-:::...-.....`./:          ',
    '          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ',
    '         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ',
    '        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ',
    '                        .-:mNdhh:.......--::::-`                    ',
    '                           yNh/..------..`                          ',
    '                                                                    ',
  },
  {
    '=================     ===============     ===============   ========  ========',
    '\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //',
    '||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||',
    '|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||',
    '||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||',
    '|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||',
    "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||",
    '|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||',
    "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||",
    "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||",
    "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||",
    "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||",
    "||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||",
    "||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||",
    "||   .=='    _-'          '-__\\._-'         '-_./__-'         `' |. /|  |   ||",
    "||.=='    _-'                                                     `' |  /==.||",
    "=='    _-'                        N E O V I M                         \\/   `==",
    "\\   _-'                                                                `-_   /",
    " `''                                                                      ``' ",
  },
}
local index = math.random(0, #asciiTable)

local header = {
  type = 'text',
  val = asciiTable[index],
  opts = {
    position = 'center',
    hl = 'Typedef',
  },
}

local footer = {
  type = 'text',
  val = 'Ahhyeahhh',
  opts = {
    position = 'center',
    hl = 'Typedef',
  },
}

local function button(sc, txt, keybind)
  local sc_ = sc:gsub('%s', ''):gsub('SPC', '<leader>')

  local opts = {
    position = 'center',
    text = txt,
    shortcut = sc,
    cursor = 5,
    width = 36,
    align_shortcut = 'right',
    hl = 'Typedef',
    hl_shortcut = 'Number',
  }

  if keybind then
    opts.keymap = { 'n', sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = 'button',
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, 'normal', false)
    end,
    opts = opts,
  }
end

local buttons = {
  type = 'group',
  val = {
    button(' n ', '  New File  ', ':enew<CR>'),
    button(' f ', '󰮗  Find File  ', ':Telescope find_files<CR>'),
    button(' r ', '  Recent Files  ', ':Telescope oldfiles<CR>'),
    button(' p ', '  Recent project  ', ':Telescope projects<CR>'),
    button(
      ' l ',
      '  Load last session  ',
      ":lua require'persistence'.setup()<CR> :lua require'persistence'.load({ last = true })<CR>"
    ),
    button(' q ', '󰅖  Quit  ', ':qa!<CR>'),
  },
  opts = {
    spacing = 1,
  },
}

local section = {
  header = header,
  buttons = buttons,
  footer = footer,
}

alpha.setup {
  layout = {
    { type = 'padding', val = 3 },
    section.header,
    { type = 'padding', val = 3 },
    section.buttons,
    { type = 'padding', val = 1 },
    section.footer,
  },
  opts = {},
}

vim.api.nvim_create_augroup('alpha_tabline', { clear = true })
vim.api.nvim_create_autocmd('User', {
  group = 'alpha_tabline',
  pattern = 'AlphaReady',
  command = 'set showtabline=0 laststatus=0',
})
vim.api.nvim_create_autocmd('User', {
  group = 'alpha_tabline',
  pattern = 'AlphaClosed',
  command = 'set showtabline=1 laststatus=3',
})
