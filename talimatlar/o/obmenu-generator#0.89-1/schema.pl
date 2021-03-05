#!/usr/bin/perl

# obmenu-generator - schema file

=for comment

    item:      add an item inside the menu               {item => ["command", "label", "icon"]},
    cat:       add a category inside the menu             {cat => ["name", "label", "icon"]},
    sep:       horizontal line separator                  {sep => undef}, {sep => "label"},
    pipe:      a pipe menu entry                         {pipe => ["command", "label", "icon"]},
    file:      include the content of an XML file        {file => "/path/to/file.xml"},
    raw:       any XML data supported by Openbox          {raw => q(...)},
    beg:       begin of a category                        {beg => ["name", "icon"]},
    end:       end of a category                          {end => undef},
    obgenmenu: generic menu settings                {obgenmenu => ["label", "icon"]},
    exit:      default "Exit" action                     {exit => ["label", "icon"]},

=cut

# NOTE:
#    * Keys and values are case sensitive. Keep all keys lowercase.
#    * ICON can be a either a direct path to an icon or a valid icon name
#    * Category names are case insensitive. (X-XFCE and x_xfce are equivalent)

require "$ENV{HOME}/.config/obmenu-generator/config.pl";

## Text editor
my $editor = $CONFIG->{editor};

our $SCHEMA = [
    {sep => 'Sık Kullanılanlar'},

    #          COMMAND                 LABEL              ICON
    {item => ['xdg-open .',       'Dosya Yöneticisi', 'system-file-manager']},
    {item => ['xterm',            'Komut Satırı',     'utilities-terminal']},
    {item => ['xdg-open http://', 'İnternet Tarayıcısı',  'web-browser']},
    {item => ['gmrun',            'Komut Çalıştır',  'system-run']},

    {sep => 'Kategoriler'},

    #          NAME            LABEL                ICON
    {cat => ['utility',     'Donatılar', 'applications-utilities']},
    {cat => ['development', 'Programlama', 'applications-development']},
    {cat => ['education',   'Eğitim',   'applications-science']},
    {cat => ['game',        'Oyunlar',       'applications-games']},
    {cat => ['graphics',    'Grafik',    'applications-graphics']},
    {cat => ['audiovideo',  'Ses ve Video',  'applications-multimedia']},
    {cat => ['network',     'İnternet',     'applications-internet']},
    {cat => ['office',      'Ofis',      'applications-office']},
    {cat => ['other',       'Diğer',       'applications-other']},
    {cat => ['settings',    'Ayarlar',    'applications-accessories']},
    {cat => ['system',      'Sistem',      'applications-system']},

    #                  LABEL          ICON
    #{beg => ['My category',  'cat-icon']},
    #          ... some items ...
    #{end => undef},

    #            COMMAND     LABEL        ICON
    #{pipe => ['obbrowser', 'Disk', 'drive-harddisk']},

    ## Generic advanced settings
    #{sep       => undef},
    #{obgenmenu => ['Openbox Settings', 'applications-engineering']},
    #{sep       => undef},

    ## Custom advanced settings
    {sep => undef},
    {beg => ['Gelişmiş Ayarlar', 'applications-engineering']},

      # Configuration files
      {item => ["$editor ~/.conkyrc",              'Conky RC',    'text-x-generic']},
      {item => ["$editor ~/.config/tint2/tint2rc", 'Tint2 Panel', 'text-x-generic']},

      # obmenu-generator category
      {beg => ['Obmenu-Generator', 'accessories-text-editor']},
        {item => ["$editor ~/.config/obmenu-generator/schema.pl", 'Menu Schema', 'text-x-generic']},
        {item => ["$editor ~/.config/obmenu-generator/config.pl", 'Menu Config', 'text-x-generic']},

        {sep  => undef},
        {item => ['obmenu-generator -s -c',    'Statik menü oluştur',             'accessories-text-editor']},
        {item => ['obmenu-generator -s -i -c', 'Simgeli statik menü oluştur',  'accessories-text-editor']},
        {sep  => undef},
        {item => ['obmenu-generator -p',       'Dinamic menü oluştur',            'accessories-text-editor']},
        {item => ['obmenu-generator -p -i',    'Simgeli dinamic menü oluştur', 'accessories-text-editor']},
        {sep  => undef},

        {item => ['obmenu-generator -d', 'Önbelleği yenile', 'view-refresh']},
      {end => undef},

      # Openbox category
      {beg => ['Openbox', 'openbox']},
        {item => ["$editor ~/.config/openbox/autostart", 'Openbox Autostart',   'text-x-generic']},
        {item => ["$editor ~/.config/openbox/rc.xml",    'Openbox RC',          'text-x-generic']},
        {item => ["$editor ~/.config/openbox/menu.xml",  'Openbox Menu',        'text-x-generic']},
        {item => ['openbox --reconfigure',               'Reconfigure Openbox', 'openbox']},
      {end => undef},
    {end => undef},

    {sep => undef},

    ## The xscreensaver lock command
    {item => ['xscreensaver-command -lock', 'Kilitle', 'system-lock-screen']},

    ## This option uses the default Openbox's "Exit" action
    #{exit => ['Çıkış', 'application-exit']},

    ## This option uses the default Openbox's "Exit" action
    {exit => ['Kapat', 'openboxkapat']},

    ## This uses the 'oblogout' menu
    # {item => ['oblogout', 'Exit', 'application-exit']},
]
