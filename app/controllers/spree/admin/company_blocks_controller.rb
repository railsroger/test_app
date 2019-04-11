module Spree
  module Admin
    class CompanyBlocksController < ResourceController
      before_action :setup_new_section, only: :edit

      def index
        redirect_to edit_object_url(CompanyBlock.find(1))
      end

      def update_sections_positions
        ApplicationRecord.transaction do
          params[:positions].each do |id, index|
            Spree::CompanyBlockSection.where(id: id).update_all(position: index)
          end
        end

        respond_to do |format|
          format.js { render plain: 'Ok' }
        end
      end

      protected

      def location_after_save
        edit_object_url(@company_block)
      end

      private

      def setup_new_section
        @company_block.sections.build if @company_block.sections.empty?
      end
    end
  end
end
