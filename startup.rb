!
@comment
# ------------------------------
# Rails Express startup file
#
# 2017-Jul-12 12:02
# ------------------------------
!
@Object
!
initialize
    self
!
@Object class 
!
create 
    obj = self.new
    obj.initialize
    obj
!
test1
    $classbrowser = ClassBrowserWindow.create
    $classbrowser.show
!
test2
    $transcript = TranscriptWindow.create
    $transcript.show
!
test3
    $workspace = WorkspaceWindow.create
    $workspace.show
!
@Window
!
initialize
    @win = create_widget 'qx.ui.window.Window', self
    dock = create_widget 'qx.ui.layout.Dock'
    @win.setLayout dock
    @win.setContentPadding 0
    self.set_caption
    self.set_height
    self.set_width
    self.set_location
    self.add_content
    self.add_buttons
    nil
!
add_button_bar
    bbar = create_widget 'qx.ui.container.Composite'
    layout = create_widget 'qx.ui.layout.HBox'
    layout.setSpacing 5
    bbar.setLayout layout
    bbar.setPadding 3, 7
    bbar.setHeight 35
    background = self.default_buttons_background
    bbar.setBackgroundColor background
    @win.add bbar, {edge: 'south'}
    buttons = self.default_buttons
    until buttons.size == 0
        item = buttons.shift
        name = item.first
        action = item.last.to_sym
        btn = create_widget 'qx.ui.form.Button', self
        btn.on :click, action
        btn.setLabel name
        bbar.add btn
    end
    nil
!
add_buttons
    buttons = self.default_buttons
    unless buttons.nil?
        self.add_button_bar
    end
    nil
!
add_content
    nil
!
default_actions
    []
!
default_buttons
    nil
!
default_buttons_background
    '#e3e3e3'
!
default_caption
    'a Window'
!
default_centered
    true
!
default_height
    275
!
default_location
    nil
!
default_width
    375
!
on_appear
    print self.class.to_s
!
set_caption
    caption = self.default_caption
    @win.setCaption caption
!
set_height
    height = self.default_height
    @win.setHeight height
!
set_location
    centered = self.default_centered
    location = self.default_location
    if centered
        @win.center
    end
    unless location.nil?
        x = location.first
        y = location.last
        @win.moveTo x, y
    end
!
set_width
    width = self.default_width
    @win.setWidth width 
!
show
    @win.show
!
win
    @win
!
@ClassBrowserWindow
!
default_buttons
    [
        ['Refresh', :refresh],
        ['Save', :save],
        ['Delete', :delete],
        ['Save Image', :save_image]
    ]
!
default_caption
    'Class Browser'
!
default_location
    [290, 7]
!
@TranscriptWindow class 
!
open
    $transcript = self.create
    $transcript.show
!
@TranscriptWindow
!
add_content
    @text = create_widget 'qx.ui.form.TextArea'
    @win.add @text, {edge: 'center'}
!
clear
    @text.setValue ''
!
default_buttons
    [['Clear', :clear]]
!
default_caption
    'Transcript'
!
default_location
    [7, 7]
!
default_width
    275
!
prn(x)
    print @text, x
!
@WorkspaceWindow
!
default_buttons
    [
        ['Eval', :eval],
        ['Clear Top', :clear_top],
        ['Clear Bottom', :clear_bottom]
    ]
!
default_caption
    'Workspace'
!
default_location
    [7, 290]
!
