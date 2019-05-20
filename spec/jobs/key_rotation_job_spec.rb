# frozen_string_literal: true

require 'rails_helper'

describe KeyRotationJob, type: :job do
  subject { KeyRotationJob.new.perform }

end
