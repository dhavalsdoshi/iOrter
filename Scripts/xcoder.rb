require 'xcoder'
project = Xcode.project('iOrter')
config = Xcode.project(:iOrter).target(:iOrterTests).config(:Debug)
builder = config.builder
builder.clean
builder.build :sdk => :iphonesimulator