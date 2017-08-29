--BF－大旆のヴァーユ
function c511002219.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89326990,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTarget(c511002219.target)
	e1:SetOperation(c511002219.operation)
	c:RegisterEffect(e1)
	--synchro limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(aux.TRUE)
	c:RegisterEffect(e2)
end
function c511002219.filter(c,tp,mc)
	return c:IsType(TYPE_SYNCHRO) and Duel.IsExistingMatchingCard(c511002219.matfilter,tp,LOCATION_GRAVE,0,1,nil,mc,c)
end
function c511002219.matfilter(c,mc,sc)
	return c:IsAbleToRemove() and sc:IsSynchroSummonable(nil,Group.FromCards(c,mc))
end
function c511002219.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),69832741) 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsAbleToRemove() 
		and Duel.IsExistingMatchingCard(c511002219.filter,tp,LOCATION_EXTRA,0,1,nil,tp,c) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511002219.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c511002219.filter,tp,LOCATION_EXTRA,0,nil,tp,c)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local mat=Duel.SelectMatchingCard(tp,c511002219.matfilter,tp,LOCATION_GRAVE,0,1,1,nil,c,tc)
		mat:AddCard(c)
		Auxiliary.SynchroSend=2
		Duel.SynchroSummon(tp,tc,nil,mat)
		Auxiliary.SynchroSend=0
	end
end
