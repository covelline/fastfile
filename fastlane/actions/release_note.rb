module Fastlane
  module Actions
    module SharedValues
      RELEASE_NOTE_OUTPUT_PATH = :RELEASE_NOTE_OUTPUT_PATH
    end

    class ReleaseNoteAction < Action
      def self.run(params)

        egrep_opt = "^\\[.+\\].+$"
        note = %x[git log --format=%B `git describe --tags --abbrev=0`.. | egrep "#{egrep_opt}" | uniq | bundle exec log2changelog 新機能 不具合修正 その他].strip

        dir = params[:output_directory]

        if dir
          path = File.expand_path(File.join(dir, "release_note.md"))
          File.write(path, note)
          Actions.lane_context[SharedValues::RELEASE_NOTE_OUTPUT_PATH] =  path
          UI.message "Create relaese note at path '#{path}' 📋"
        else
          puts note
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "リリースノートを作る奴"
      end

      def self.details
        "ヽ(•̀ω•́ )ゝ✧"
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :output_directory,
                                       env_name: "FL_RELEASE_NOTE_OUTPUT_DIRECTORY",
                                       description: "リリースノートを保存する場所. 指定しない場合は標準出力される",
                                       optional: true)
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['RELEASE_NOTE_OUTPUT_PATH', 'output directory of release note']
        ]
      end

      def self.return_value
        # If you method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["covelline, LLC.", "mironal"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
