!
@comment
# ------------------------------
# Rails Express startup file
#
# 2017-Jul-14 11:56
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
    # copy this to the workspace (without the method name) and eval
    # simple loop test
    x = 0
    while x < 100
        x += 1
        print 'x = %s  x**3 = %s' % [x, x**3]
    end
!
test2
    # array test
    x = [1, 2, 3, 4, 5]
    y = [6, 7, 8, 9, 10]
    print x + y
!
test3
    # hash test
    x = {a: 123, b: 456}
    y = {d: 789}
    print (x.merge y).to_s
!
test4
    # creating some windows
    $w1 = TranscriptWindow.open
    $w1.win.setCaption 'WINDOW ONE'
    $w1.prn 'HELLO WORLD ONE'
    $w2 = TranscriptWindow.open
    $w2.win.setCaption 'WINDOW TWO'
    $w2.prn 'HELLO WORLD TWO'
    $w3 = TranscriptWindow.open
    $w3.win.setCaption 'WINDOW THREE'
    $w3.prn 'HELLO WORLD THREE'
    $w1.win.moveTo 100, 15
    $w2.win.moveTo 400, 15
    $w3.win.moveTo 700, 15
    nil
!
test5
    # must run test4 first
    $w1.win.setHeight 175
    $w2.win.setHeight 275
    $w3.win.setHeight 375
    $w1.clear
    $w1.prn 'This is window 1'
    $w1.prn 'This is window 1'
    $w1.prn 'This is window 1'
    $w2.clear
    $w2.prn 'This is window 2'
    $w2.prn 'This is window 2'
    $w2.prn 'This is window 2'
    $w3.clear
    $w3.prn 'This is window 3'
    $w3.prn 'This is window 3'
    $w3.prn 'This is window 3'
!
test6
    # must run test5 first
    $w1.win.close 
    $w2.win.close 
    $w3.win.close 
    $w1 = Window.open
    $w2 = Window.open
    $w3 = Window.open
    $w1.win.moveTo 100, 15
    $w2.win.moveTo 350, 15
    $w3.win.moveTo 600, 15
    $w1.win.setWidth 200
    $w2.win.setWidth 200
    $w3.win.setWidth 200
    $w1.win.setBackgroundColor 'red'
    $w2.win.setBackgroundColor 'yellow'
    $w3.win.setBackgroundColor 'orange'
!
test7
    # must run test6 first
    $w2.win.close 
    $w3.win.close
    $w1.win.setBackgroundColor '#e3e3e3'
    $w1.win.moveTo 350, 15
    $w1.win.setWidth 575
    $textarea = create_widget 'qx.ui.form.TextArea'
    $w1.win.add $textarea, {edge: 0}
    $textarea.setValue 'This is a TEXTAREA widget'
!
test8
    # browse messages
    MessageBrowserWindow.open
!
test9
    # browse users
    UserBrowserWindow.open
!
@Window class
!
open
    w = self.create
    w.show
    w 
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
    @win.on :appear, :on_appear
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
@MessageBrowserWindow
!
default_caption
    'Message Browser'
!
get_columns
    model_columns :message
!
get_data
    model_data :message
!
@ModelBrowserWindow
!
add_content
    @split = create_widget 'qx.ui.splitpane.Pane'
    @list = create_widget :table_widget
    x = self.get_columns
    @list.set_columns x
    @right = create_widget 'qx.ui.form.TextArea'
    @split.add @list
    @split.add @right
    @win.add @split, {edge: 'center'}
!
default_buttons
    [
        ['Refresh', :refresh]
    ]
!
default_caption
    'Model Browser'
!
default_height
    375
!
default_width
    525
!
get_columns
    []
!
get_data
    []
!
list
    @list
!
on_appear
    self.refresh
!
refresh
    x = self.get_data
    @list.set_data x
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
@UserBrowserWindow
!
default_caption
    'User Browser'
!
get_columns
    model_columns :user
!
get_data
    model_data :user
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
