Spree::Admin::TaxonsController.class_eval do
  before_action :setup_new_menu_items, only: :edit

  def update_left_menu_items_positions
    ApplicationRecord.transaction do
      params[:positions].each do |id, index|
        Spree::TaxonsLeftMenuItem.where(id: id).update_all(position: index)
      end
    end

    respond_to do |format|
      format.js { render plain: 'Ok' }
    end
  end

  def update_right_menu_items_positions
    ApplicationRecord.transaction do
      params[:positions].each do |id, index|
        Spree::TaxonsRightMenuItem.where(id: id).update_all(position: index)
      end
    end

    respond_to do |format|
      format.js { render plain: 'Ok' }
    end
  end

  protected

  def location_after_save
    edit_object_url(@taxon)
  end

  private

  def taxon_params
    params.require(:taxon).permit!
  end

  def setup_new_menu_items
    @taxon.left_menu_items.build if @taxon.left_menu_items.empty?
    @taxon.right_menu_items.build if @taxon.right_menu_items.empty?
  end
end
