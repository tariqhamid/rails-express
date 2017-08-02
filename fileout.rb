# ==========================
# Rails Express
# fileout.rb
#
# 2017-08-02 20:09:05 UTC
# ==========================

class Object

def self.create
    obj = self.new
    obj.initialize
    obj
end # def

def self.prn(s)
    $transcript.prn s
end # def

def self.test
    self.test_messages
    self.test_users
    WorkspaceWindow.open
    ClassBrowserWindow.open
end # def

def self.test2
    w = TranscriptWindow.open
    self.test_transcript w, 100, 4
end # def

def self.test_messages
    # browse messages
    MessageBrowserWindow.open
end # def

def self.test_transcript(w, a, b)
    w.prn a/b
end # def

def self.test_users
    # browse users
    UserBrowserWindow.open
end # def

def initialize
    self
end # def

def prn(s)
    self.klass.prn s
end # def

end # class

class Admin < Object
end # class

class AppAdmin < Admin

def self.start
    AppBrowserWindow.open
end # def

end # class

class DataAdmin < Admin

def self.start
    DataAdminWindow.open
end # def

end # class

class HelpAdmin < Admin

def self.start
    HelpBrowserWindow.open
end # def

end # class

class Application < Object

def self.start
    print 'Application start'
end # def

end # class

class Demo < Application
end # class

class PizzaDelivery < Demo

def self.start
    # PizzaDelivery.start
    TranscriptWindow.open
    $transcript.set_taller
    PizzaDeliveryWindow.open
end # def

end # class

class Game < Application
end # class

class TicTacToe < Game

def self.start
    # TicTacToe.start
    TranscriptWindow.open
    $transcript.set_taller
    TicTacToeWindow.open
end # def

end # class

class Database < Object
end # class

class DataMigrations < Database
end # class

class DataSeeding < Database
end # class

class Ui < Object
end # class

class Component < Ui

def create_widget
    @widget = Widget.create_textarea
end # def

def initialize
    self.create_widget
    @owner = nil
end # def

def owner
    @owner
end # def

def set_owner(object)
    @owner = object
end # def

def widget
    @widget
end # def

end # class

class PizzaDeliveryPage < Component

def clear

end # def

def create_widget
    @widget = Widget.create_tabpage
    @widget.setLabel self.get_label
    @widget.setLayout Widget.create_dock
end # def

end # class

class PizzaDeliveryMessagesPage < PizzaDeliveryPage

def add_detail
    @form = Widget.create_form
    @form.add_fields self.get_fields
    @split.add @form
end # def

def add_list
    @list = Widget.create :table_widget, self
    @list.set_columns self.get_columns
    @list.on :changeSelection, :on_change_selection
    @split.add @list
end # def

def create_widget
    super.create_widget
    @split = Widget.create 'qx.ui.splitpane.Pane', nil, 'vertical'
    self.add_list
    self.add_detail
    @widget.add @split, {edge: 'center'}
end # def

def get_columns
    Model.model_columns self.get_model_name
end # def

def get_fields
    Model.model_fields self.get_model_name
end # def

def get_label
    'Messages'
end # def

def get_model_name
    :pizza_message
end # def

end # class

class PizzaDeliveryOrderPage < PizzaDeliveryPage

def clear
    @form.reset
end # def

def create_widget
    super.create_widget
    @form = Widget.create_form
    @form.add_fields self.get_fields
    @widget.add @form
end # def

def get_fields
    Model.model_fields self.get_model_name
end # def

def get_label
    'Order'
end # def

def get_model_name
    :pizza_order
end # def

def update(record)
    @form.update record
end # def

end # class

class Viewport < Ui
end # class

class AppViewport < Viewport
end # class

class DevViewport < Viewport
end # class

class Widget < Ui

def self.create_button
    self.create 'qx.ui.form.Button'
end # def

def self.create_composite
    self.create 'qx.ui.container.Composite'
end # def

def self.create_decorator
    self.create 'qx.ui.decoration.Decorator'
end # def

def self.create_dock
    self.create 'qx.ui.layout.Dock'
end # def

def self.create_form
    self.create :form_widget
end # def

def self.create_grid_layout
    self.create 'qx.ui.layout.Grid'
end # def

def self.create_hbox
    self.create 'qx.ui.layout.HBox'
end # def

def self.create_monaco_editor
    self.create :monaco_editor_widget
end # def

def self.create_paper
    self.create :paper_widget
end # def

def self.create_split_pane
    self.create 'qx.ui.splitpane.Pane'
end # def

def self.create_tabpage
    self.create 'qx.ui.tabview.Page'
end # def

def self.create_tabview
    self.create 'qx.ui.tabview.TabView'
end # def

def self.create_textarea
    self.create 'qx.ui.form.TextArea'
end # def

def self.create_textfield
    self.create 'qx.ui.form.TextField'
end # def

def self.create_tinymce_editor
    self.create :tinymce_widget
end # def

def self.create_window
    self.create 'qx.ui.window.Window'
end # def

end # class

class Button < Widget
end # class

class Container < Widget
end # class

class Form < Widget
end # class

class Iframe < Widget
end # class

class MonacoEditorWidget < Iframe
end # class

class TabPage < Widget
end # class

class TabView < Widget
end # class

class Tree < Widget
end # class

class Window < Ui

def self.open
    w = self.create
    w.show
    w
end # def

def add_button_bar
    @bbar = Widget.create_composite
    layout = Widget.create_hbox
    layout.setSpacing 5
    @bbar.setLayout layout
    @bbar.setPadding 3, 7
    @bbar.setHeight 35
    background = self.default_buttons_background
    @bbar.setBackgroundColor background
    @win.add @bbar, {edge: 'south'}
    self.add_button_bar_text_fields
    buttons = self.default_buttons
    until buttons.empty?
        item = buttons.shift
        name = item[0]
        action = item[1]
        args = item[2]
        btn = Widget.create 'qx.ui.form.Button', self
        btn.on :click, action, args
        btn.setLabel name
        @bbar.add btn
    end
    @win.on :appear, :on_appear
    nil
end # def

def add_button_bar_text_fields
    if self.default_bb_text_field_width > 0
        @bbar_text_field = Widget.create_textfield
        @bbar_text_field.setWidth self.default_bb_text_field_width
        @bbar.add @bbar_text_field
    end
end # def

def add_buttons
    buttons = self.default_buttons
    unless buttons.nil?
        self.add_button_bar
    end
    nil
end # def

def add_content
    nil
end # def

def close
    @win.close
end # def

def default_actions
    []
end # def

def default_bb_text_field_width
    -1
end # def

def default_buttons
    nil
end # def

def default_buttons_background
    '#e3e3e3'
end # def

def default_caption
    'a Window'
end # def

def default_centered
    true
end # def

def default_height
    275
end # def

def default_location
    nil
end # def

def default_width
    375
end # def

def initialize
    @win = Widget.create 'qx.ui.window.Window', self
    dock = Widget.create_dock
    @win.setLayout dock
    @win.setContentPadding 0
    self.set_caption
    self.set_height
    self.set_width
    self.set_location
    self.add_content
    self.add_buttons
    nil
end # def

def on_appear

end # def

def set_caption
    caption = self.default_caption
    @win.setCaption caption
end # def

def set_height
    height = self.default_height
    @win.setHeight height
end # def

def set_location
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
end # def

def set_width
    width = self.default_width
    @win.setWidth width
end # def

def show
    @win.show
end # def

def win
    @win
end # def

end # class

class AdminWindow < Window

def default_height
    475
end # def

def default_width
    575
end # def

end # class

class DataAdminWindow < AdminWindow

def default_caption
    'Data Administration'
end # def

end # class

class DemoWindow < Window

def default_height
    475
end # def

def default_width
    575
end # def

end # class

class PizzaDeliveryWindow < DemoWindow

def add_content
    @split = Widget.create_split_pane
    self.add_list
    self.add_tabs
    @win.add @split, {edge: 'center'}
end # def

def add_list
    @list = Widget.create :table_widget, self
    @list.set_columns self.get_columns
    @split.add @list
    @list.on :changeSelection, :on_change_selection
end # def

def add_tabs
    @tabs = Widget.create_tabview
    @tabs.setContentPadding 0
    @split.add @tabs
    @order_page = PizzaDeliveryOrderPage.create
    @messages_page = PizzaDeliveryMessagesPage.create
    @tabs.add @order_page.widget
    @tabs.add @messages_page.widget
end # def

def clear
    @list.reset_selection
    @order_page.clear
    @messages_page.clear
end # def

def default_buttons
    [
        ['Refresh', :on_refresh],
        ['New', :on_new],
        ['Ready', :on_ready],
        ['Picked Up', :on_picked_up],
        ['Driver', :on_driver],
        ['Delivered', :on_delivered],
        ['Cancel Order', :on_cancel],
        ['Send Message', :on_send_message]
    ]
end # def

def default_caption
    'Pizza Delivery Application'
end # def

def format_rec(rec)
    id = rec[0]
    raw_time = rec[1]
    code = rec[2]
    status = rec[3]
    time = self.format_time raw_time
    [id, time, code, status]
end # def

def format_time(raw_time)
    raw_time.to_s.slice 11,8
end # def

def get_columns
    Model.model_columns self.get_model_name
end # def

def get_data
    raw_data = Model.model_data self.get_model_name
    data = []
    i = 0
    while i < raw_data.size
        rec = raw_data[i]
        data.push(self.format_rec rec)
        i += 1
    end
    data
end # def

def get_model_name
    :pizza_order
end # def

def on_appear
    self.refresh
end # def

def on_cancel
    self.prn 'on_cancel'
end # def

def on_change_selection(id)
    record = Model.model_record self.get_model_name, id
    unless record.nil?
        @id = id
        @order_page.update record
    end
end # def

def on_delivered
    self.prn 'on_delivered'
end # def

def on_driver
    self.prn 'on_driver'
end # def

def on_new
    self.prn 'on_new'
end # def

def on_picked_up
    self.prn 'on_picked_up'
end # def

def on_ready
    self.prn 'on_ready'
end # def

def on_refresh
    self.refresh
end # def

def on_send_message
    self.prn 'on_send_message'
end # def

def refresh
    @list.set_data self.get_data
    self.clear
end # def

end # class

class GameWindow < Window

def alert_msg(msg)
    self.prn '** %s' % msg
end # def

def default_height
    475
end # def

def default_width
    475
end # def

def info_msg(msg)
    self.prn '-- %s' % msg
end # def

def status_msg(msg)
    self.prn '== %s' % msg
end # def

def strong_msg(msg)
    self.prn '** %s' % msg.upcase
end # def

end # class

class PaperWindow < GameWindow

def add_content
    @paper = Widget.create_paper
    @win.add @paper
end # def

def default_buttons
    [
        ['Clear', :on_clear]
    ]
end # def

def default_caption
    'Paper Graphics'
end # def

def on_clear
    @paper.clear
end # def

end # class

class TiledGameWindow < GameWindow

def add_content
    @tile_map = {}
    cls = @tile_map.class
    @tile_panel = Widget.create_composite
    @tile_panel.setBackgroundColor '#ccc'
    @layout = Widget.create_grid_layout
    @tile_panel.setLayout @layout
    self.set_layout_flex
    self.add_tiles
    @win.add @tile_panel, {edge: 'center'}
    self.add_winner_patterns
    self.reset
end # def

def add_tile(x, y)
    tile = Widget.create 'qx.ui.form.Button', self
    tile.setMargin 1
    tile.setRich true
    decorator = Widget.create_decorator
    decorator.setBackgroundColor 'white'
    tile.setDecorator decorator
    key = self.create_key x, y
    tile.on :click, :on_tile_clicked, {x: x, y: y, key: key}
    @tile_panel.add tile, {column: x, row: y}
    @tile_map[key] = tile
end # def

def add_tiles
    y = 0
    while y < self.tile_size_y
        x = 0
        while x < self.tile_size_x
            self.add_tile x, y
            x += 1
        end
        y += 1
    end
end # def

def add_winner_patterns
    @winner_patterns = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
end # def

def change_player
    if @human_plays
        @human_plays = false
    else
        @human_plays = true
    end
end # def

def check_end_of_game
    return if @game_over
    if @filled_tiles.index(nil).nil?
        @game_over = true
    end
    unless @game_over
        self.change_player
        unless @human_plays
            self.play_robot
        end
    end
    unless @displayed_winner
        if @game_over
            @displayed_winner = true
            self.status_msg 'GAME OVER'
        end
    end
end # def

def check_pattern(pattern)
    i = 0
    hits = 0
    player = nil
    while i < pattern.size
        index = pattern[i]
        x = @filled_tiles[index]
        unless x.nil?
            if player.nil?
                player = x
            end
            if player == x 
                hits += 1
            end
        end
        i += 1
    end
    if hits == pattern.size
        @game_over = true
        self.strong_msg '%s wins!' % self.get_player_name
    end
end # def

def check_winner
    i = 0
    while i < @winner_patterns.size
        self.check_pattern @winner_patterns[i]
        i += 1
    end
end # def

def create_key(x, y)
   'x:%s-y:%s' % [x, y]
end # def

def default_buttons
    [
        ['Reset', :on_reset]
    ]
end # def

def format_label(label)
    style = 'font-size:4em;font-weight:bold;'
    '<span style="%s">%s</span>' % [style, label]
end # def

def get_marker
    if @human_plays
        'X'
    else
        'O'
    end
end # def

def get_player_name
    if @human_plays
        'human'
    else
        'robot'
    end
end # def

def mark_tile(x, y, tile)
    player_name = self.get_player_name
    marker = self.get_marker
    tile.setLabel self.format_label(marker)
    index = y * self.tile_size_x + x
    @filled_tiles[index] = marker
    msg = '%s plays %s at %s, %s' % [get_player_name, marker, x, y]
    self.info_msg msg
    self.check_winner
    self.check_end_of_game
end # def

def mark_tile_x_y(x, y)
    key = self.create_key x, y 
    tile = @tile_map[key]
    self.mark_tile x, y, tile
end # def

def on_reset
    self.reset
end # def

def on_tile_clicked(arg)
    unless @game_over
        x = arg['x']
        y = arg['y']
        key = arg['key']
        tile = @tile_map[key]
        self.mark_tile x, y, tile
    end
end # def

def play_robot
    unless @game_over
        index = @filled_tiles.index nil
        y = index / self.tile_size_x
        x = index % self.tile_size_x
        self.mark_tile_x_y x, y
    end
end # def

def reset
    $transcript.clear
    @filled_tiles = []
    @displayed_winner = false
    @game_over = false
    @human_plays = true
    values = @tile_map.values
    i = 0
    while i < values.size
        @filled_tiles.push nil
        v = values[i]
        v.setLabel ''
        i += 1
    end
    self.status_msg 'human starts'
end # def

def set_layout_flex
    x = 0
    while x < self.tile_size_x
        @layout.setColumnFlex x, 1
        x += 1
    end
    y = 0
    while y < self.tile_size_y
        @layout.setRowFlex y, 1
        y += 1
    end
end # def

def tile_size
    2
end # def

def tile_size_x
    self.tile_size
end # def

def tile_size_y
    self.tile_size
end # def

end # class

class TicTacToeWindow < TiledGameWindow

def default_caption
    'Tic-Tac-Toe'
end # def

def tile_size
    3
end # def

end # class

class ModelBrowserWindow < Window

def add_content
    @split = Widget.create_split_pane
    self.add_list
    self.add_detail
    @win.add @split, {edge: 'center'}
end # def

def add_detail
    @form = Widget.create_form
    @form.add_fields self.get_fields
    @split.add @form
end # def

def add_list
    @list = Widget.create :table_widget, self
    @list.set_columns self.get_columns
    @split.add @list
    @list.on :changeSelection, :on_change_selection
end # def

def clear
    @id = -1
    @list.reset_selection
    self.clear_bbar
    self.clear_detail
end # def

def clear_bbar
    if self.default_bb_text_field_width > 0
        @bbar_text_field.setValue ''
    end
end # def

def clear_detail
    @form.reset
end # def

def default_buttons
    refresh_btn = ['Refresh', :on_refresh]
    save_btn = ['Save', :on_save]
    save_btn.push self.get_save_fields unless self.get_save_fields.nil?
    new_btn = ['New', :on_new]
    delete_btn = ['Delete', :on_delete]
    btns = []
    btns.push refresh_btn
    btns.push save_btn
    btns.push new_btn
    btns.push delete_btn
    btns
end # def

def default_caption
    'Model Browser'
end # def

def default_height
    375
end # def

def default_width
    525
end # def

def get_columns
    Model.model_columns self.get_model_name
end # def

def get_data
    Model.model_data self.get_model_name
end # def

def get_fields
    Model.model_fields self.get_model_name
end # def

def get_model_name
    :dummy
end # def

def get_save_fields
    [[:get_save_fields, @form]]
end # def

def list
    @list
end # def

def on_appear
    self.refresh
end # def

def on_change_selection(id)
    record = Model.model_record self.get_model_name, id
    unless record.nil?
        @id = id
        @form.update record
    end
end # def

def on_delete
    Model.model_delete self.get_model_name, @id
    self.refresh
end # def

def on_new
    self.clear
end # def

def on_refresh
    self.refresh
end # def

def on_save(arg)
    self.prn arg.to_s
end # def

def refresh
    @list.set_data self.get_data
    self.clear
end # def

end # class

class AppBrowserWindow < ModelBrowserWindow

def default_caption
    'App Browser'
end # def

def get_model_name
    :app
end # def

def on_save(arg)
    owner = arg['owner']
    title = arg['title']
    tag = arg['tag']
    cmd = arg['cmd']
    Model.model_save self.get_model_name, @id, owner, title, tag, cmd
    self.refresh
end # def

end # class

class HelpBrowserWindow < ModelBrowserWindow

def add_detail
    @editor = Widget.create_tinymce_editor
    @split.add @editor
end # def

def clear_detail
    @editor.set_value ''
end # def

def default_bb_text_field_width
    250
end # def

def default_caption
    'Help Browser'
end # def

def get_model_name
    :help
end # def

def get_save_fields
    [[:getValue, @bbar_text_field], [:get_value, @editor]]
end # def

def on_change_selection(id)
    record = Model.model_record self.get_model_name, id
    unless record.nil?
        @id = record['id']
        @bbar_text_field.setValue record['topic']
        @editor.set_value record['text']
    end
end # def

def on_save(topic, text)
    Model.model_save self.get_model_name, @id, topic, text
    self.refresh
end # def

end # class

class MessageBrowserWindow < ModelBrowserWindow

def default_caption
    'Message Browser'
end # def

def get_model_name
    :message
end # def

end # class

class UserBrowserWindow < ModelBrowserWindow

def default_caption
    'User Browser'
end # def

def get_model_name
    :user
end # def

def on_save(arg)
    email = arg['email']
    first_name = arg['first_name']
    last_name = arg['last_name']
    Model.model_save self.get_model_name, @id, email, first_name, last_name
    self.refresh
end # def

end # class

class ToolWindow < Window
end # class

class ClassBrowserWindow < ToolWindow

def add_content
    @vsplit = Widget.create 'qx.ui.splitpane.Pane', nil, 'vertical'
    @hsplit = Widget.create_split_pane
    @text = Widget.create_monaco_editor
    @tree = Widget.create_textarea
    @tabs = Widget.create_textarea
    @hsplit.add @tree
    @hsplit.add @tabs
    @vsplit.add @hsplit
    @vsplit.add @text
    @win.add @vsplit, {edge: 'center'}
end # def

def default_buttons
    [
        ['Refresh', :on_refresh],
        ['Save', :on_save],
        ['Delete', :on_delete],
        ['Save Image', :on_save_image]
    ]
end # def

def default_caption
    'Class Browser'
end # def

def default_location
    [290, 7]
end # def

def on_delete
    print 'on_delete'
end # def

def on_fileout
    print 'on_fileout'
end # def

def on_refresh
    print 'on_refresh'
end # def

def on_save
    print 'on_save'
end # def

def on_save_image
    print 'on_save_image'
end # def

end # class

class MessageBox < ToolWindow

def self.msg(text)
    mb = self.open
    mb.set_text text
    mb
end # def

def add_content
    @text = Widget.create_textarea
    @win.add @text
end # def

def default_buttons
    [
        ['Ok', :on_ok],
        ['Cancel', :on_cancel]
    ]
end # def

def default_caption
    'Message Box'
end # def

def default_height
    175
end # def

def default_width
    275
end # def

def on_cancel
    self.close
end # def

def on_ok
    self.close
end # def

def set_text(text)
    @text.setValue text
end # def

end # class

class TranscriptWindow < ToolWindow

def self.open
    $transcript = super.open
end # def

def add_content
    @text = Widget.create_textarea
    @win.add @text, {edge: 'center'}
end # def

def clear
    @text.setValue ''
end # def

def default_buttons
    [['Clear', :clear]]
end # def

def default_caption
    'Transcript'
end # def

def default_location
    [7, 52]
end # def

def default_width
    275
end # def

def prn(x)
    print @text, x
end # def

def set_taller
    self.win.setHeight self.default_height + 100
end # def

end # class

class WorkspaceWindow < ToolWindow

def add_content
    @split = Widget.create_split_pane
    @editor = Widget.create_monaco_editor
    @output = Widget.create_textarea
    @split.add @editor
    @split.add @output
    @win.add @split, {edge: 'center'}
end # def

def clear_left
    @editor.set_value ''
end # def

def clear_right
    @output.setValue ''
end # def

def default_buttons
    id = @editor.id
    [
        ['Eval', :eval, [[:get_value, @editor]]],
        ['Clear Left', :clear_left],
        ['Clear Right', :clear_right]
    ]
end # def

def default_caption
    'Workspace'
end # def

def default_location
    [7, 290]
end # def

def eval(s)
    Vm.compile_and_run s, self
end # def

def prn(x)
    print @output, x
end # def

end # class

class Vm < Object
end # class

class Behavior < Vm
end # class

class Class < Behavior
end # class

class MetaClass
end # class

class Boolean < Vm
end # class

class False < Boolean
end # class

class True < Boolean
end # class

class Collection < Vm
end # class

class OrderedCollection < Collection
end # class

class Array < OrderedCollection
end # class

class Context < Vm
end # class

class Block < Context
end # class

class MethodContext < Context
end # class

class Kernel < Vm
end # class

class CompiledMethod < Kernel
end # class

class Model < Kernel
end # class

class Magnitude < Vm
end # class

class Number < Magnitude
end # class

class Float < Number
end # class

class Integer < Number
end # class

class UndefinedObject < Vm
end # class

