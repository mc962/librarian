# == Schema Information
#
# Table name: examples
#
#  id         :bigint           not null, primary key
#  command    :text             not null
#  output     :text
#  comment    :text
#  codelet_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Example < ApplicationRecord
    belongs_to :codelet

    attr_accessor :markdown_command,
                  :markdown_output

    validates :command, presence: true
    validates_length_of :command, maximum: 500
    validates_length_of :output, maximum: 500
    validates_length_of :comment, maximum: 1000

    # Determines if example should be publicly accessible, 
    # based on if associated codelet is publicly accessible
    #
    # @return [Boolean]
    def publicly_accessible?
        codelet.publicly_accessible?
    end

    # Outputs markdown text within markdown_command attribute as HTML with Redcarpet gem
    #
    # @return [String]
    def markdown_command_html
        if self.markdown_command 
            self.markdown_command
        else
            self.markdown_command = MARKDOWN_RENDERER.render(self.command)
        end
    end

    # Outputs markdown text within markdown_command attribute as HTML with Redcarpet gem
    #
    # @return [String]
    def markdown_output_html
        
        if self.markdown_output
            self.markdown_output
        else
            self.markdown_output = MARKDOWN_RENDERER.render(self.output)
        end
    end
end
