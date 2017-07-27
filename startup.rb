# ==========================
# railsexpress.rb
#
# 2017-07-27 20:38:12 UTC
# ==========================

class Object

def self.create
    obj = self.new
    obj.initialize
    obj
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
    $transcript.prn s
end # def

end # class

class Applications < Object
end # class

class Demos < Applications
end # class

class EditorDemo < Demos

def self.open
    EditorWindow.open
end # def

end # class

class PaperDemo < Demos

def self.open
    PaperWindow.open
end # def

end # class

class Behavior < Object
end # class

class Class < Behavior
end # class

class MetaClass
end # class

class Boolean < Object
end # class

class False < Boolean
end # class

class True < Boolean
end # class

class Collection < Object
end # class

class OrderedCollection < Collection
end # class

class Array < OrderedCollection
end # class

class Context < Object
end # class

class Block < Context
end # class

class MethodContext < Context
end # class

class Kernel < Object
end # class

class CompiledMethod < Kernel
end # class

class Model < Kernel
end # class

class Vm < Kernel
end # class

class Magnitude < Object
end # class

class Number < Magnitude
end # class

class Float < Number
end # class

class Integer < Number
end # class

class Ui < Object
end # class

class Widget < Ui

def self.create_composite
    self.create 'qx.ui.container.Composite'
end # def

def self.create_dock
    self.create 'qx.ui.layout.Dock'
end # def

def self.create_form
    self.create :form_widget
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

class Viewport < Widget
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
    nil
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

class ClassBrowserWindow < Window

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

class EditorWindow < Window

def add_content
    @editor = Widget.create_tinymce_editor
    @win.add @editor
end # def

def default_buttons
    [
        ['Clear', :on_clear]
    ]
end # def

def default_caption
    'Rich Text Editor'
end # def

def on_clear
    @editor.set_value ''
end # def

end # class

class HelpBrowserWindow < Window

def add_button_bar_text_fields
    @id = -1
    @text_field = Widget.create_textfield
    @text_field.setWidth 250
    @bbar.add @text_field
end # def

def add_content
    @split = Widget.create_split_pane
    @list = Widget.create :table_widget, self
    @editor = Widget.create_tinymce_editor
    @list.set_columns self.get_columns
    @split.add @list
    @split.add @editor
    @win.add @split, {edge: 'center'}
    @list.on :changeSelection, :on_change_selection
end # def

def default_buttons
    [
        ['Refresh', :on_refresh],
        ['Save', :on_save, [[:getValue, @text_field], [:get_value, @editor]]],
        ['Delete', :on_delete]
    ]
end # def

def default_caption
    'Help Browser'
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
    :help
end # def

def on_change_selection(id)
    record = Model.model_record self.get_model_name, id
    @id = record['id']
    @text_field.setValue record['topic']
    @editor.set_value record['text']
end # def

def on_delete
    print 'on_delete'
end # def

def on_refresh
    @list.set_data self.get_data
end # def

def on_save(topic, text)
    Model.model_save self.get_model_name, @id, topic, text
end # def

end # class

class MessageBox < Window

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

class ModelBrowserWindow < Window

def add_content
    @split = Widget.create_split_pane
    @list = Widget.create :table_widget, self
    @form = Widget.create_form
    @list.set_columns self.get_columns
    @form.add_fields self.get_fields
    @split.add @list
    @split.add @form
    @win.add @split, {edge: 'center'}
    @list.on :changeSelection, :on_change_selection
end # def

def default_buttons
    [
        ['Refresh', :refresh]
    ]
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

def list
    @list
end # def

def on_appear
    self.refresh
end # def

def on_change_selection(id)
    record = Model.model_record self.get_model_name, id
    @form.update record
end # def

def refresh
    @list.set_data self.get_data
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

end # class

class PaperWindow < Window

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

class TranscriptWindow < Window

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
    [7, 7]
end # def

def default_width
    275
end # def

def prn(x)
    print @text, x
end # def

end # class

class WorkspaceWindow < Window

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

class UndefinedObject < Object
end # class

