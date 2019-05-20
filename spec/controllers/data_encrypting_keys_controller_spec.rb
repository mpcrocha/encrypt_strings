require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe DataEncryptingKeysController, type: :request do

  describe '#rotate' do

    subject do
      post "/data_encrypting_keys/rotate"
      response
    end

    context 'when job is successfully enqueued' do
      before do
        allow_any_instance_of(Sidekiq::Queue).to receive(:size).and_return(0)
        allow_any_instance_of(Sidekiq::Workers).to receive(:size).and_return(0)
      end

      it { expect { subject }.to have_enqueued_job.on_queue('key_rotation').exactly(:once) }
    end

    context 'when job is not successfully enqueued because a job is enqueued' do
      before do
        allow_any_instance_of(Sidekiq::Queue).to receive(:size).and_return(1)
        allow_any_instance_of(Sidekiq::Workers).to receive(:size).and_return(0)
      end

      it { expect { subject }.not_to have_enqueued_job.on_queue('key_rotation').exactly(:once) }
    end

    context 'when job is not successfully enqueued because a job is progress' do
      before do
        allow_any_instance_of(Sidekiq::Queue).to receive(:size).and_return(0)
        allow_any_instance_of(Sidekiq::Workers).to receive(:size).and_return(1)
      end

      it { expect { subject }.not_to have_enqueued_job.on_queue('key_rotation').exactly(:once) }
    end
  end

  describe '#status' do

    subject do
      get "/data_encrypting_keys/status"
      response
    end

    context 'when there is a job enqueued' do

      before do
        allow_any_instance_of(Sidekiq::Queue).to receive(:size).and_return(1)
        allow_any_instance_of(Sidekiq::Workers).to receive(:size).and_return(0)
      end

      it { expect(JSON.parse(subject.body, symbolize_names: true)[:message]).to eq 'Key rotation has been queued' }
    end

    context 'when there is a job in progress' do

      before do
        allow_any_instance_of(Sidekiq::Queue).to receive(:size).and_return(0)
        allow_any_instance_of(Sidekiq::Workers).to receive(:size).and_return(1)
      end

      it { expect(JSON.parse(subject.body, symbolize_names: true)[:message]).to eq 'Key rotation is in progress' }
    end

    context 'when there is no job enqueued or in progress' do

      before do
        allow_any_instance_of(Sidekiq::Queue).to receive(:size).and_return(0)
        allow_any_instance_of(Sidekiq::Workers).to receive(:size).and_return(0)
      end

      it { expect(JSON.parse(subject.body, symbolize_names: true)[:message]).to eq 'No key rotation queued or in progress' }
    end

  end

end