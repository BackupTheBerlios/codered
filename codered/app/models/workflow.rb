class Workflow < ActiveRecord::Base
has_one :user
has_one :ticket
validates_presence_of :workflow_text, :user_id , :ticket_id
#Es muss ein Workflow_text vorhanden sein, sonst ist der auch sinnlos
#user_id und ticket_id sollten zwar immer mitgegeben werde, aber man weis ja nie
end
