require 'spec_helper'

module Capistrano
  describe Env do
    let(:app) { stub(:app) }
    let(:web) { stub(:web) }
    let(:db)  { stub(:db) }

    describe ".configure" do
      let(:configuration) { Env.configuration }

      before do
        SSHKit::Host.expects(:new).with('app.com').returns(app)
        SSHKit::Host.expects(:new).with('web.com').returns(web)
        SSHKit::Host.expects(:new).with('db.com').returns(db)
      end

      it "configures" do
        Env.configure do |config|
          config.role :app, %w{app.com}
          config.role :web, %w{web.com}
          config.role :db, %w{db.com}
          config.user 'tomc'
          config.path '/var/www/my_app/current'
        end

        expect(configuration.roles).to eq({
          app: [app],
          web: [web],
          db: [db]
        })
        expect(configuration.user).to eq 'tomc'
        expect(configuration.path).to eq '/var/www/my_app/current'
      end
    end

    let(:env) { Env.new }

    describe "#role" do
      before do
        SSHKit::Host.expects(:new).with('example.com').returns(app)
      end

      it "adds a role" do
        env.role(:app, %w{example.com})
        expect(env.roles).to eq({app: [app]})
      end
    end

    describe "#respond_to?" do
      context "key is set" do
        it "returns true" do
          env.this_is_a_test true
          expect(env.respond_to?(:this_is_a_test)).to be_true
        end
      end

      context "key is not set" do
        it "returns false" do
          expect(env.respond_to?(:this_is_a_test)).to be_false
        end
      end
    end
  end
end
