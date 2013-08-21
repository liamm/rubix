require 'rubix/messages/message'
require 'rubix/messages/message_types'
require 'rubix/messages/message_tags'
require 'rubix/messages/field'
require 'rubix/messages/repeating_group'
require 'rubix/messages/repeat'
require 'rubix/parser'
require 'rubix/version'

# TODO: Validate length, checksum, repeat length (+ repeat integrity, i.e. each group has same tags)

# execution_report = Rubix.parse(str) # => Rubix::Messages::ExecutionReport.new
# execution_report.symbol # => MSFT

# execution_report.to_s # => str
# execution_report.to_hash # => {} of values

#str = "8=FIX.4.2\00135=8\001268=2\001269=Bid\001269=Offer"

#str = "8=FIX.4.2\0019=178\00135=8\00149=PHLX\00156=PERS\00152=20071123-05:30:00.000\00111=ATOMNOCCC9990900\00120=3\001150=E\00139=E\00155=MSFT\001167=CS\00154=1\00138=15\00140=2\00144=15\00158=PHLX EQUITY TESTING\00159=0\00147=C\00132=0\00131=0\001151=15\00114=0\0016=0\00110=128\001"

#p Rubix::Parser.parse(str)